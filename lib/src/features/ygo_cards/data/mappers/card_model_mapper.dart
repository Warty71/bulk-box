import 'dart:convert';

import 'package:bulk_box/src/core/database/app_database.dart';
import 'package:bulk_box/src/features/ygo_cards/data/models/card_model.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/card_set.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';

class CardModelMapper {
  /// Parses an API response map into [YgoCard] domain entities and
  /// corresponding Drift [Card] rows for DB storage.
  static ({List<YgoCard> entities, List<Card> rows}) fromApiResponse(
    Map<String, dynamic> response,
  ) {
    try {
      if (!response.containsKey('data')) {
        return (entities: <YgoCard>[], rows: <Card>[]);
      }

      final data = response['data'];
      if (data == null) return (entities: <YgoCard>[], rows: <Card>[]);

      List<dynamic> cardList;
      if (data is List) {
        cardList = data;
      } else if (data is Map<String, dynamic>) {
        cardList = [data];
      } else {
        return (entities: <YgoCard>[], rows: <Card>[]);
      }

      final entities = <YgoCard>[];
      final rows = <Card>[];

      for (final cardJson in cardList) {
        try {
          final model = CardModel.fromJson(cardJson);
          final uniqueSets = _deduplicateCardSets(model.cardSets);
          entities.add(_toYgoCard(model, uniqueSets));
          rows.add(_toDriftCard(model, uniqueSets));
        } catch (_) {
          // Skip unparseable cards
        }
      }

      return (entities: entities, rows: rows);
    } catch (_) {
      return (entities: <YgoCard>[], rows: <Card>[]);
    }
  }

  /// Converts a [YgoCard] domain entity back into a Drift [Card] for DB storage.
  static Card toDriftCard(YgoCard ygoCard) {
    final cardSetsJson = jsonEncode(
      ygoCard.cardSets
          .map((s) => {
                'set_name': s.setName,
                'set_code': s.setCode,
                'set_rarity': s.setRarity,
                if (s.setEdition != null) 'set_edition': s.setEdition,
                if (s.setPrice != null) 'set_price': s.setPrice,
                if (s.setPriceLow != null) 'set_price_low': s.setPriceLow,
                if (s.setUrl != null) 'set_url': s.setUrl,
              })
          .toList(),
    );

    return Card(
      id: ygoCard.id,
      name: ygoCard.name,
      type: ygoCard.type,
      description: ygoCard.description,
      race: ygoCard.race,
      frameType: ygoCard.frameType,
      attribute: ygoCard.attribute,
      level: ygoCard.level,
      atk: ygoCard.atk,
      def: ygoCard.def,
      archetype: ygoCard.archetype,
      imageUrl: ygoCard.imageUrl,
      cardSetsJson: cardSetsJson,
    );
  }

  /// Converts a Drift [Card] row (from DB) into a [YgoCard] domain entity.
  static YgoCard fromDriftCard(Card card) {
    final sets = _parseSetsJson(card.cardSetsJson);
    return YgoCard(
      id: card.id,
      name: card.name,
      type: card.type,
      description: card.description,
      race: card.race,
      frameType: card.frameType,
      attribute: card.attribute,
      level: card.level,
      atk: card.atk,
      def: card.def,
      archetype: card.archetype,
      imageUrl: card.imageUrl,
      cardSets: sets,
    );
  }

  static YgoCard _toYgoCard(CardModel model, List<CardSetModel> uniqueSets) {
    final imageUrl =
        model.cardImages.isNotEmpty ? model.cardImages.first.imageUrl : '';
    return YgoCard(
      id: model.id,
      name: model.name,
      type: model.type,
      description: model.desc,
      race: model.race,
      frameType: model.frameType,
      attribute: model.attribute,
      level: model.level,
      atk: model.atk,
      def: model.def,
      archetype: model.archetype,
      imageUrl: imageUrl,
      cardSets: uniqueSets
          .map((s) => CardSet(
                setName: s.setName,
                setCode: s.setCode,
                setRarity: s.setRarity,
                setEdition: s.setEdition,
                setPrice: s.setPrice,
                setPriceLow: s.setPriceLow,
                setUrl: s.setUrl,
              ))
          .toList(),
    );
  }

  static Card _toDriftCard(CardModel model, List<CardSetModel> uniqueSets) {
    final imageUrl =
        model.cardImages.isNotEmpty ? model.cardImages.first.imageUrl : '';
    final cardSetsJson = jsonEncode(
      uniqueSets
          .map((s) => {
                'set_name': s.setName,
                'set_code': s.setCode,
                'set_rarity': s.setRarity,
                if (s.setEdition != null) 'set_edition': s.setEdition,
                if (s.setPrice != null) 'set_price': s.setPrice,
                if (s.setPriceLow != null) 'set_price_low': s.setPriceLow,
                if (s.setUrl != null) 'set_url': s.setUrl,
              })
          .toList(),
    );

    return Card(
      id: model.id,
      name: model.name,
      type: model.type,
      description: model.desc,
      race: model.race,
      frameType: model.frameType,
      attribute: model.attribute,
      level: model.level,
      atk: model.atk,
      def: model.def,
      archetype: model.archetype,
      imageUrl: imageUrl,
      cardSetsJson: cardSetsJson,
    );
  }

  static List<CardSet> _parseSetsJson(String cardSetsJson) {
    try {
      final list = jsonDecode(cardSetsJson) as List;
      final parsed = list.map((e) {
        final m = e as Map<String, dynamic>;
        return CardSet(
          setName: m['set_name'] as String? ?? '',
          setCode: m['set_code'] as String? ?? '',
          setRarity: m['set_rarity'] as String? ?? '',
          setEdition: m['set_edition'] as String?,
          setPrice: m['set_price'] as String?,
          setPriceLow: m['set_price_low'] as String?,
          setUrl: m['set_url'] as String?,
        );
      }).toList();
      return _deduplicateCardSets2(parsed);
    } catch (_) {
      return [];
    }
  }

  static List<CardSetModel> _deduplicateCardSets(List<CardSetModel> sets) {
    final seen = <String>{};
    return sets.where((s) {
      final key = '${s.setCode}|${s.setRarity}';
      if (seen.contains(key)) return false;
      seen.add(key);
      return true;
    }).toList();
  }

  static List<CardSet> _deduplicateCardSets2(List<CardSet> sets) {
    final seen = <String>{};
    return sets.where((s) {
      final key = '${s.setCode}|${s.setRarity}';
      if (seen.contains(key)) return false;
      seen.add(key);
      return true;
    }).toList();
  }
}
