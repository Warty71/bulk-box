import 'package:ygo_collector/src/features/collection/data/datasources/local/image_local_datasource.dart';
import 'package:ygo_collector/src/features/collection/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/card.dart';
import 'package:ygo_collector/src/features/collection/domain/repositories/card_repository.dart';

class CardRepositoryImpl implements CardRepository {
  final YGOProApiDatasource _apiDatasource;
  final ImageLocalDatasource _imageLocalDatasource;

  CardRepositoryImpl(this._apiDatasource, this._imageLocalDatasource);

  @override
  Future<List<Card>> searchCards(String query) async {
    final response = await _apiDatasource.searchCards(query);
    return _transformToCards(response);
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
    // TODO: Implement transformation from API response to Card entities
    throw UnimplementedError();
  }
}
