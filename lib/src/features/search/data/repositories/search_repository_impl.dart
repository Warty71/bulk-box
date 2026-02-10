import 'dart:convert';

import 'package:bulk_box/src/core/database/app_database.dart';
import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/core/utils/rate_limiter.dart';
import 'package:bulk_box/src/features/search/domain/repositories/search_repository.dart';
import 'package:bulk_box/src/features/ygo_cards/data/datasources/local/image_local_datasource.dart';
import 'package:bulk_box/src/features/ygo_cards/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:bulk_box/src/features/ygo_cards/data/models/card_model.dart';

class SearchRepositoryImpl implements SearchRepository {
  final YGOProApiDatasource _apiDatasource;
  final ImageLocalDatasource _imageLocalDatasource;
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
    this._imageLocalDatasource,
    this._cardDao,
  );

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

  Future<List<Card>> _fetchAndCacheCards(String query) async {
    final response = await _apiDatasource.searchCards(query);
    final cards = _parseAndConvertToDriftCards(response);

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

      if (!await _imageLocalDatasource.isImageSaved(card.id)) {
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

            final imageBytes = await _apiDatasource.getCardImage(card.id);
            await _imageLocalDatasource.saveImage(card.id, imageBytes);
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

  List<Card> _parseAndConvertToDriftCards(Map<String, dynamic> response) {
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
              final model = CardModel.fromJson(cardJson);
              return _cardModelToDriftCard(model);
            } catch (e) {
              return null;
            }
          })
          .whereType<Card>()
          .toList();

      return cards;
    } catch (e) {
      return [];
    }
  }

  /// Deduplicates card sets by [CardSetModel.setCode] and [CardSetModel.setRarity].
  /// Keeps first occurrence when duplicates exist (e.g. API returning same set twice).
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
      imageUrl: imageUrl,
      cardSetsJson: cardSetsJson,
    );
  }
}
