import 'package:bulk_box/src/core/database/app_database.dart';
import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/core/utils/rate_limiter.dart';
import 'package:bulk_box/src/features/search/domain/repositories/search_repository.dart';
import 'package:bulk_box/src/features/ygo_cards/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:bulk_box/src/features/ygo_cards/data/mappers/card_model_mapper.dart';
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
  Future<List<Card>> searchCardsLocal(String query) async {
    return await _cardDao.searchCardsByName(query);
  }

  @override
  Future<List<Card>> searchCards(String query) async {
    try {
      if (query.isEmpty) {
        final cachedCards = await _cardDao.searchCardsByName('');
        if (cachedCards.isNotEmpty) {
          return cachedCards;
        }
        return await _fetchAndCacheCards(
            'type=Normal Monster&sort=name&offset=0&num=20');
      }

      return await _fetchAndCacheCards(query);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Card>> _fetchAndCacheCards(String query) async {
    final response = await _apiDatasource.searchCards(query);
    final cards = CardModelMapper.fromApiResponse(response);

    if (cards.isNotEmpty) {
      await _cardDao.insertOrUpdateCards(cards);

      _currentPrefetchId++;
      final cardsToPrefetch = cards.take(_maxPrefetchCards).toList();
      _prefetchImages(cardsToPrefetch, _currentPrefetchId);
    }

    return cards;
  }

  Future<void> _prefetchImages(List<Card> cards, int prefetchId) async {
    const batchSize = 15;

    final cardsToFetch = <Card>[];
    for (final card in cards) {
      if (prefetchId != _currentPrefetchId) {
        return;
      }

      if (!await _imageRepository.isCardImageSaved(card.id)) {
        cardsToFetch.add(card);
      }
    }

    for (var i = 0; i < cardsToFetch.length; i += batchSize) {
      if (prefetchId != _currentPrefetchId) {
        return;
      }

      final batch = cardsToFetch.skip(i).take(batchSize).toList();

      await Future.wait(
        batch.map((card) async {
          try {
            await _rateLimiter.waitIfNeeded();
            if (prefetchId != _currentPrefetchId) return;

            await _imageRepository.getCardImagePath(card.id);
          } catch (e) {
            // Silently handle prefetch errors
          }
        }),
      );

      if (i + batchSize < cardsToFetch.length) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
  }

}
