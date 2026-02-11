import 'dart:convert';

import 'package:bulk_box/src/core/database/app_database.dart';
import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/core/utils/rate_limiter.dart';
import 'package:bulk_box/src/features/ygo_cards/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:bulk_box/src/features/ygo_cards/data/models/card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArchetypeBackfillService {
  final YGOProApiDatasource _apiDatasource;
  final CardDao _cardDao;
  final SharedPreferences _prefs;

  static const _prefKey = 'archetype_backfill_complete';

  final _rateLimiter = RateLimiter(
    maxRequests: 5,
    timeWindow: const Duration(seconds: 1),
  );

  ArchetypeBackfillService(this._apiDatasource, this._cardDao, this._prefs);

  Future<void> backfill({
    void Function(int done, int total)? onProgress,
  }) async {
    if (_prefs.getBool(_prefKey) == true) return;

    final cardIds = await _cardDao.getCardIdsWithoutArchetype();
    if (cardIds.isEmpty) {
      await _prefs.setBool(_prefKey, true);
      return;
    }

    final total = cardIds.length;
    for (var i = 0; i < total; i++) {
      try {
        await _rateLimiter.waitIfNeeded();
        final response =
            await _apiDatasource.searchCards('id=${cardIds[i]}');
        final cards = _parseAndConvertToDriftCards(response);
        if (cards.isNotEmpty) {
          await _cardDao.insertOrUpdateCards(cards);
        }
      } catch (_) {
        // Skip errors per card, continue with next
      }
      onProgress?.call(i + 1, total);
    }

    await _prefs.setBool(_prefKey, true);
  }

  List<Card> _parseAndConvertToDriftCards(Map<String, dynamic> response) {
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
            return _cardModelToDriftCard(model);
          } catch (_) {
            return null;
          }
        })
        .whereType<Card>()
        .toList();
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

  Card _cardModelToDriftCard(CardModel model) {
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
}
