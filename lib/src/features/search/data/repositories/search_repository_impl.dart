import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/core/utils/rate_limiter.dart';
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
  Future<List<YgoCard>> searchCards(String query) async {
    return await _fetchAndCacheCards(query);
  }

  Future<List<YgoCard>> _fetchAndCacheCards(String query) async {
    final response = await _apiDatasource.searchCards(query);
    final result = CardModelMapper.fromApiResponse(response);

    if (result.rows.isNotEmpty) {
      await _cardDao.insertOrUpdateCards(result.rows);

      _currentPrefetchId++;
      final cardIds =
          result.entities.take(_maxPrefetchCards).map((c) => c.id).toList();
      _prefetchImages(cardIds, _currentPrefetchId);
    }

    return result.entities;
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
