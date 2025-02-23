import 'package:ygo_collector/src/features/collection/data/datasources/local/image_local_datasource.dart';
import 'package:ygo_collector/src/features/collection/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:ygo_collector/src/features/collection/data/datasources/local/card_local_datasource.dart';
import 'package:ygo_collector/src/features/collection/data/models/card_model.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/card.dart';
import 'package:ygo_collector/src/features/collection/domain/repositories/card_repository.dart';

class CardRepositoryImpl implements CardRepository {
  final YGOProApiDatasource _apiDatasource;
  final ImageLocalDatasource _imageLocalDatasource;
  final CardLocalDatasource _cardLocalDatasource;

  CardRepositoryImpl(
    this._apiDatasource,
    this._imageLocalDatasource,
    this._cardLocalDatasource,
  );

  @override
  Future<List<Card>> searchCards(String query) async {
    print('📱 Repository: Searching cards with query: "$query"');

    try {
      // First try to find cards in local cache
      final cachedCards = await _cardLocalDatasource.getCachedCards();
      print('📱 Repository: Found ${cachedCards.length} cached cards');

      if (query.isEmpty) {
        if (cachedCards.isEmpty) {
          // If no cached cards, get initial set from API
          print('📱 Repository: Cache empty, fetching initial cards');
          final response = await _apiDatasource
              .searchCards('type=Normal Monster&sort=name&offset=0&num=20');
          final cards = _transformToCards(response);
          print(
              '📱 Repository: Fetched ${cards.length} initial cards from API');
          await _cardLocalDatasource.cacheCards(
              cards.map((card) => _transformToModel(card)).toList());
          return cards;
        }
        return cachedCards.map(_transformToEntity).toList();
      }

      // Search remotely
      final response = await _apiDatasource.searchCards(query);
      final cards = _transformToCards(response);
      print('📱 Repository: Found ${cards.length} cards from API');

      // Cache the new cards
      await _cardLocalDatasource
          .cacheCards(cards.map((card) => _transformToModel(card)).toList());

      return cards;
    } catch (e, stackTrace) {
      print('❌ Repository: Error searching cards: $e');
      print('❌ Repository: Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<Card> getCardDetails(int cardId) async {
    final response = await _apiDatasource.searchCards('id:$cardId');
    return _transformToCards(response).first;
  }

  @override
  Future<String> getLocalImagePath(int cardId) async {
    if (!await _imageLocalDatasource.isImageSaved(cardId)) {
      final imageBytes = await _apiDatasource.getCardImage(cardId);
      await _imageLocalDatasource.saveImage(cardId, imageBytes);
    }
    return _imageLocalDatasource.getImagePath(cardId);
  }

  @override
  Future<void> saveCardImage(int cardId, List<int> imageBytes) async {
    await _imageLocalDatasource.saveImage(cardId, imageBytes);
  }

  @override
  Future<bool> isCardImageSaved(int cardId) async {
    return _imageLocalDatasource.isImageSaved(cardId);
  }

  List<Card> _transformToCards(Map<String, dynamic> response) {
    print('📱 Repository: Transforming API response to cards');
    try {
      if (!response.containsKey('data')) {
        print('❌ Repository: Invalid API response format - missing data field');
        return [];
      }

      final data = response['data'];
      if (data == null) {
        print('❌ Repository: No cards found in API response');
        return [];
      }

      // Handle both single card and list responses
      List<dynamic> cardList;
      if (data is List) {
        cardList = data;
      } else if (data is Map<String, dynamic>) {
        cardList = [data];
      } else {
        print(
            '❌ Repository: Invalid data type in response: ${data.runtimeType}');
        return [];
      }

      final cards = cardList
          .map((cardJson) {
            try {
              final cardModel = CardModel.fromJson(cardJson);
              return _transformToEntity(cardModel);
            } catch (e) {
              print('❌ Repository: Error transforming card: $e');
              return null;
            }
          })
          .whereType<Card>()
          .toList();

      print('📱 Repository: Successfully transformed ${cards.length} cards');
      return cards;
    } catch (e) {
      print('❌ Repository: Error during transformation: $e');
      return [];
    }
  }

  Card _transformToEntity(CardModel model) {
    try {
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

      return Card(
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
    } catch (e) {
      print('❌ Repository: Error transforming entity: $e');
      rethrow;
    }
  }

  CardModel _transformToModel(Card entity) {
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
