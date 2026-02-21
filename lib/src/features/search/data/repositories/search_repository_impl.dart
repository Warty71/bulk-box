import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/core/utils/rate_limiter.dart';
import 'package:bulk_box/src/features/search/domain/entities/card_search_filters.dart';
import 'package:bulk_box/src/features/search/domain/repositories/search_repository.dart';
import 'package:bulk_box/src/features/ygo_cards/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:bulk_box/src/features/ygo_cards/data/mappers/card_model_mapper.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/repositories/image_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final YGOProApiDatasource _apiDatasource;
  final ImageRepository _imageRepository;
  final CardDao _cardDao;

  // Rate limiter: 18 requests per second (slightly under 20/sec limit for safety)
  static final _rateLimiter = RateLimiter(
    maxRequests: 18,
    timeWindow: const Duration(seconds: 1),
  );

  // Track current prefetch operation to allow cancellation
  int _currentPrefetchId = 0;
  static const int _maxPrefetchCards = 30;

  SearchRepositoryImpl(
    this._apiDatasource,
    this._imageRepository,
    this._cardDao,
  );

  @override
  Future<List<YgoCard>> searchCards(String query,
      {CardSearchFilters? filters}) async {
    return await _fetchAndCacheCards(query, filters: filters);
  }

  Future<List<YgoCard>> _fetchAndCacheCards(String query,
      {CardSearchFilters? filters}) async {
    final params = <String, dynamic>{'tcgplayer_data': 'yes'};
    if (query.isNotEmpty) params['fname'] = query;
    if (filters != null) {
      // CardType is always applied client-side (see below). The API `type`
      // param requires exact compound strings and silently excludes sub-variants
      // (e.g. `type=Synchro Monster` misses Synchro Tuner Monster).
      if (filters.attribute != null) {
        params['attribute'] = filters.attribute!.apiValue;
      }
      if (filters.race != null) params['race'] = filters.race!.apiValue;
      if (filters.level != null) params['level'] = filters.level.toString();
    }

    // Guard: never call the API with no meaningful server-side filter — it
    // would return every card in the database. CardType and MonsterSubtype are
    // client-side only and do not count as meaningful API params.
    final hasMeaningfulParam = params.keys.any((k) => k != 'tcgplayer_data');
    if (!hasMeaningfulParam) return [];

    final response = await _apiDatasource.searchCards(params);
    final result = CardModelMapper.fromApiResponse(response);

    var entities = result.entities;

    // Client-side CardType filter — OR across all selected types.
    // Multiple selections (e.g. Synchro + XYZ) return cards matching ANY type.
    // Pendulum uses contains() because its frameType values are compound
    // strings like 'effect_pendulum'; all others use exact equality.
    if (filters != null && filters.types.isNotEmpty) {
      entities = entities.where((c) {
        return filters.types.any((t) {
          if (t == CardType.pendulumMonster) {
            return c.frameType?.contains(t.frameTypeValue) == true;
          }
          return c.frameType == t.frameTypeValue;
        });
      }).toList();
    }

    // Client-side MonsterSubtype filter — OR across all selected subtypes.
    // The API encodes subtypes inside the compound type string, e.g.:
    //   "Synchro Tuner Monster" → contains "Tuner"
    //   "Flip Tuner Effect Monster" → contains "Flip" and "Tuner"
    // Multiple selections (e.g. Tuner + Flip) return cards matching ANY keyword.
    if (filters != null && filters.subtypes.isNotEmpty) {
      entities = entities.where((c) {
        return filters.subtypes.any((s) => c.type.contains(s.typeKeyword));
      }).toList();
    }

    if (result.rows.isNotEmpty) {
      await _cardDao.insertOrUpdateCards(result.rows);

      _currentPrefetchId++;
      // Prefetch images for the unfiltered set so they are cached for later.
      final cardIds =
          result.entities.take(_maxPrefetchCards).map((c) => c.id).toList();
      _prefetchImages(cardIds, _currentPrefetchId);
    }

    return entities;
  }

  Future<void> _prefetchImages(List<int> cardIds, int prefetchId) async {
    const batchSize = 15;

    final idsToFetch = <int>[];
    for (final id in cardIds) {
      if (prefetchId != _currentPrefetchId) {
        return;
      }

      if (!await _imageRepository.isCardImageSaved(id)) {
        idsToFetch.add(id);
      }
    }

    for (var i = 0; i < idsToFetch.length; i += batchSize) {
      if (prefetchId != _currentPrefetchId) {
        return;
      }

      final batch = idsToFetch.skip(i).take(batchSize).toList();

      await Future.wait(
        batch.map((id) async {
          try {
            await _rateLimiter.waitIfNeeded();
            if (prefetchId != _currentPrefetchId) return;

            await _imageRepository.getCardImagePath(id);
          } catch (e) {
            // Silently handle prefetch errors
          }
        }),
      );

      if (i + batchSize < idsToFetch.length) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
  }
}
