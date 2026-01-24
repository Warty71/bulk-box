import 'package:ygo_collector/src/core/utils/rate_limiter.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/datasources/local/image_local_datasource.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/entities/ygo_card.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/models/card_model.dart';
import 'package:ygo_collector/src/features/search/domain/repositories/search_repository.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/datasources/local/card_local_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final YGOProApiDatasource _apiDatasource;
  final ImageLocalDatasource _imageLocalDatasource;
  final CardLocalDatasource _cardLocalDatasource;

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
    this._imageLocalDatasource,
    this._cardLocalDatasource,
  );

  @override
  Future<List<YgoCard>> searchCards(String query) async {
    try {
      // First try to find cards in local cache
      final cachedCards = await _cardLocalDatasource.getCachedCards();

      if (query.isEmpty) {
        if (cachedCards.isNotEmpty) {
          return cachedCards.map(_transformToEntity).toList();
        }
        // If no cached cards, get initial set from API
        return await _fetchAndCacheCards(
            'type=Normal Monster&sort=name&offset=0&num=20');
      }

      return await _fetchAndCacheCards(query);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getCardImagePath(int cardId) async {
    try {
      if (!await _imageLocalDatasource.isImageSaved(cardId)) {
        final imageBytes = await _apiDatasource.getCardImage(cardId);
        await _imageLocalDatasource.saveImage(cardId, imageBytes);
      }
      return await _imageLocalDatasource.getImagePath(cardId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isCardImageSaved(int cardId) async {
    return await _imageLocalDatasource.isImageSaved(cardId);
  }

  Future<List<YgoCard>> _fetchAndCacheCards(String query) async {
    final response = await _apiDatasource.searchCards(query);
    final cards = _transformToCards(response);

    if (cards.isNotEmpty) {
      // Cache the new cards
      await _cardLocalDatasource
          .cacheCards(cards.map((card) => _transformToModel(card)).toList());

      // Cancel any ongoing prefetch and start new one
      _currentPrefetchId++;
      // Prefetch images in the background (with rate limiting)
      // Only prefetch first 50 cards to avoid excessive API calls
      final cardsToPrefetch = cards.take(_maxPrefetchCards).toList();
      _prefetchImages(cardsToPrefetch, _currentPrefetchId);
    }

    return cards;
  }

  Future<void> _prefetchImages(List<YgoCard> cards, int prefetchId) async {
    const batchSize = 15; // Process 15 at a time (under 20/sec limit)

    // Filter cards that need images
    final cardsToFetch = <YgoCard>[];
    for (final card in cards) {
      // Check if this prefetch was cancelled
      if (prefetchId != _currentPrefetchId) {
        return;
      }

      if (!await _imageLocalDatasource.isImageSaved(card.id)) {
        cardsToFetch.add(card);
      }
    }

    // Process in batches
    for (var i = 0; i < cardsToFetch.length; i += batchSize) {
      // Check if this prefetch was cancelled before each batch
      if (prefetchId != _currentPrefetchId) {
        return;
      }

      final batch = cardsToFetch.skip(i).take(batchSize).toList();

      // Process batch with rate limiting
      await Future.wait(
        batch.map((card) async {
          try {
            await _rateLimiter.waitIfNeeded();
            // Double-check cancellation before API call
            if (prefetchId != _currentPrefetchId) return;

            final imageBytes = await _apiDatasource.getCardImage(card.id);
            await _imageLocalDatasource.saveImage(card.id, imageBytes);
          } catch (e) {
            // Comment
          }
        }),
      );

      // Small delay between batches to ensure we're under the limit
      if (i + batchSize < cardsToFetch.length) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
  }

  List<YgoCard> _transformToCards(Map<String, dynamic> response) {
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

      final cards = cardList
          .map((cardJson) {
            try {
              final cardModel = CardModel.fromJson(cardJson);
              final card = _transformToEntity(cardModel);

              return card;
            } catch (e) {
              // Comment
              return null;
            }
          })
          .whereType<YgoCard>()
          .toList();

      return cards;
    } catch (e) {
      return [];
    }
  }

  YgoCard _transformToEntity(CardModel model) {
    final cardImage = model.cardImages.isNotEmpty
        ? model.cardImages.first
        : CardImageModel(
            id: model.id,
            imageUrl: '',
            imageUrlSmall: '',
          );

    final cardSets = model.cardSets
        .map((set) => CardSet(
              setName: set.setName,
              setCode: set.setCode,
              setRarity: set.setRarity,
            ))
        .toList();

    return YgoCard(
      id: model.id,
      name: model.name,
      type: model.type,
      description: model.desc,
      race: model.race,
      attribute: model.attribute,
      level: model.level,
      atk: model.atk,
      def: model.def,
      imageUrl: cardImage.imageUrl,
      cardSets: cardSets,
      isLocalImageAvailable: false,
    );
  }

  CardModel _transformToModel(YgoCard entity) {
    return CardModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      desc: entity.description,
      race: entity.race,
      attribute: entity.attribute,
      level: entity.level,
      atk: entity.atk,
      def: entity.def,
      cardImages: [
        CardImageModel(
          id: entity.id,
          imageUrl: entity.imageUrl,
          imageUrlSmall: entity.imageUrl,
        ),
      ],
      cardSets: entity.cardSets
          .map((set) => CardSetModel(
                setName: set.setName,
                setCode: set.setCode,
                setRarity: set.setRarity,
              ))
          .toList(),
    );
  }
}
