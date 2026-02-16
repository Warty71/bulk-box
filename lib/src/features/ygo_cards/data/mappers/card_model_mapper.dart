import 'dart:convert';

import 'package:bulk_box/src/core/database/app_database.dart';
import 'package:bulk_box/src/features/ygo_cards/data/models/card_model.dart';

class CardModelMapper {
  /// Parses an API response map into a list of Drift [Card] objects.
  static List<Card> fromApiResponse(Map<String, dynamic> response) {
    try {
      if (!response.containsKey('data')) return [];

      final data = response['data'];
      if (data == null) return [];

      List<dynamic> cardList;
      if (data is List) {
        cardList = data;
      } else if (data is Map<String, dynamic>) {
        cardList = [data];
      } else {
        return [];
      }

      return cardList
          .map((cardJson) {
            try {
              final model = CardModel.fromJson(cardJson);
              return fromCardModel(model);
            } catch (_) {
              return null;
            }
          })
          .whereType<Card>()
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// Converts a [CardModel] into a Drift [Card].
  static Card fromCardModel(CardModel model) {
    final imageUrl =
        model.cardImages.isNotEmpty ? model.cardImages.first.imageUrl : '';
    final uniqueSets = _deduplicateCardSets(model.cardSets);
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

  /// Deduplicates card sets by [CardSetModel.setCode] and [CardSetModel.setRarity].
  /// Keeps first occurrence when duplicates exist.
  static List<CardSetModel> _deduplicateCardSets(List<CardSetModel> sets) {
    final seen = <String>{};
    return sets.where((s) {
      final key = '${s.setCode}|${s.setRarity}';
      if (seen.contains(key)) return false;
      seen.add(key);
      return true;
    }).toList();
  }
}
