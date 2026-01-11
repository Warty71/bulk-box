import 'package:flutter/foundation.dart';
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
  static const int _maxPrefetchCards = 30; // Limit prefetching to first 30 cards

  SearchRepositoryImpl(
    this._apiDatasource,
    this._imageLocalDatasource,
    this._cardLocalDatasource,
  );

  @override
  Future<List<YgoCard>> searchCards(String query) async {
    if (kDebugMode) {
      print('searchCards called with query: "$query"');
    }
    try {
      // First try to find cards in local cache
      final cachedCards = await _cardLocalDatasource.getCachedCards();

      if (query.isEmpty) {
        if (cachedCards.isNotEmpty) {
          if (kDebugMode) {
            // ignore: avoid_print
            print('Returning ${cachedCards.length} cached cards (no API call)');
          }
          return cachedCards.map(_transformToEntity).toList();
        }
        // If no cached cards, get initial set from API
        if (kDebugMode) {
          // ignore: avoid_print
          print('No cached cards found, fetching initial set from API');
        }
        return await _fetchAndCacheCards(
            'type=Normal Monster&sort=name&offset=0&num=20');
      }

      // Always search the API for non-empty queries (API is source of truth)
      // Cache is only used for empty queries or as fallback
      if (kDebugMode) {
        // ignore: avoid_print
        print('Searching API for query: "$query"');
      }
      return await _fetchAndCacheCards(query);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<YgoCard> getCardDetails(int cardId) async {
    final response = await _apiDatasource.searchCards('id:$cardId');
    return _transformToCards(response).first;
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
    if (kDebugMode) {
      print('API call triggered with query: "$query"');
    }
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
        if (kDebugMode) {
          // ignore: avoid_print
          print('Prefetch cancelled (new search started)');
        }
        return;
      }
      
      if (!await _imageLocalDatasource.isImageSaved(card.id)) {
        cardsToFetch.add(card);
      }
    }

    if (kDebugMode && cardsToFetch.isNotEmpty) {
      // ignore: avoid_print
      print('Prefetching ${cardsToFetch.length} card images in batches of $batchSize (ID: $prefetchId)');
    }

    // Process in batches
    for (var i = 0; i < cardsToFetch.length; i += batchSize) {
      // Check if this prefetch was cancelled before each batch
      if (prefetchId != _currentPrefetchId) {
        if (kDebugMode) {
          // ignore: avoid_print
          print('Prefetch cancelled during batch processing (ID: $prefetchId)');
        }
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
            if (kDebugMode) {
              // ignore: avoid_print
              print('Prefetched image for card: ${card.name} (ID: ${card.id})');
            }
          } catch (e) {
            if (kDebugMode) {
              // ignore: avoid_print
              print('Error prefetching image for card ${card.id}: $e');
            }
            // Ignore prefetch errors
          }
        }),
      );

      // Small delay between batches to ensure we're under the limit
      if (i + batchSize < cardsToFetch.length) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }

    if (kDebugMode && cardsToFetch.isNotEmpty && prefetchId == _currentPrefetchId) {
      // ignore: avoid_print
      print('Completed prefetching ${cardsToFetch.length} card images (ID: $prefetchId)');
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
              
              // Debug print - only in debug mode
              if (kDebugMode) {
                print('Card loaded: ${card.name} (ID: ${card.id})');
                print('  Type: ${card.type}, Race: ${card.race}');
                if (card.attribute != null) print('  Attribute: ${card.attribute}');
                if (card.level != null) print('  Level: ${card.level}');
                if (card.atk != null) print('  ATK: ${card.atk}');
                if (card.def != null) print('  DEF: ${card.def}');
                print('  Sets: ${card.cardSets.length}');
              }
              
              return card;
            } catch (e) {
              if (kDebugMode) {
                print('Error parsing card: $e');
              }
              return null;
            }
          })
          .whereType<YgoCard>()
          .toList();
      
      if (kDebugMode) {
        print('Total cards loaded: ${cards.length}');
      }
      
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
