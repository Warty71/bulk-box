import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/core/utils/rate_limiter.dart';
import 'package:bulk_box/src/features/ygo_cards/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:bulk_box/src/features/ygo_cards/data/mappers/card_model_mapper.dart';
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
        final result = CardModelMapper.fromApiResponse(response);
        if (result.rows.isNotEmpty) {
          await _cardDao.insertOrUpdateCards(result.rows);
        }
      } catch (_) {
        // Skip errors per card, continue with next
      }
      onProgress?.call(i + 1, total);
    }

    await _prefs.setBool(_prefKey, true);
  }

}
