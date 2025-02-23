import 'package:ygo_collector/src/core/ygo_cards/data/datasources/local/image_local_datasource.dart';
import 'package:ygo_collector/src/core/ygo_cards/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:ygo_collector/src/core/ygo_cards/data/entities/ygo_card.dart';
import 'package:ygo_collector/src/core/ygo_cards/data/models/card_model.dart';
import 'package:ygo_collector/src/features/search/domain/repositories/search_repository.dart';
import 'package:ygo_collector/src/core/ygo_cards/data/datasources/local/card_local_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final YGOProApiDatasource _apiDatasource;
  final ImageLocalDatasource _imageLocalDatasource;
  final CardLocalDatasource _cardLocalDatasource;

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

      // Try to find matching cards in cache first
      final matchingCachedCards = cachedCards
          .where(
              (card) => card.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (matchingCachedCards.isNotEmpty) {
        return matchingCachedCards.map(_transformToEntity).toList();
      }

      // If no matches in cache, search remotely
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
    final response = await _apiDatasource.searchCards(query);
    final cards = _transformToCards(response);

    if (cards.isNotEmpty) {
      // Cache the new cards and fetch their images
      await Future.wait([
        _cardLocalDatasource
            .cacheCards(cards.map((card) => _transformToModel(card)).toList()),
        ..._prefetchImages(cards),
      ]);
    }

    return cards;
  }

  List<Future<void>> _prefetchImages(List<YgoCard> cards) {
    return cards.map((card) async {
      if (!await _imageLocalDatasource.isImageSaved(card.id)) {
        try {
          final imageBytes = await _apiDatasource.getCardImage(card.id);
          await _imageLocalDatasource.saveImage(card.id, imageBytes);
        } catch (e) {
          // Ignore prefetch errors
        }
      }
    }).toList();
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

      return cardList
          .map((cardJson) {
            try {
              final cardModel = CardModel.fromJson(cardJson);
              return _transformToEntity(cardModel);
            } catch (e) {
              return null;
            }
          })
          .whereType<YgoCard>()
          .toList();
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

    final cardSet = model.cardSets.isNotEmpty
        ? model.cardSets.first
        : CardSetModel(
            setName: '',
            setCode: '',
            setRarity: '',
            setPrice: '',
          );

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
      setCode: cardSet.setCode,
      setRarity: cardSet.setRarity,
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
      cardSets: [
        CardSetModel(
          setName: '', // Not available in entity
          setCode: entity.setCode,
          setRarity: entity.setRarity,
          setPrice: '0', // Not available in entity
        ),
      ],
    );
  }
}
