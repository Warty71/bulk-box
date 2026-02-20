import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/features/ygo_cards/data/datasources/local/image_local_datasource.dart';
import 'package:bulk_box/src/features/ygo_cards/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageLocalDatasource _imageLocalDatasource;
  final YGOProApiDatasource _apiDatasource;
  final CardDao _cardDao;

  ImageRepositoryImpl(
    this._imageLocalDatasource,
    this._apiDatasource,
    this._cardDao,
  );

  @override
  Future<String> getCardImagePath(int cardId) async {
    if (!await _imageLocalDatasource.isImageSaved(cardId)) {
      final card = await _cardDao.getCardById(cardId);
      if (card == null || card.imageUrl.isEmpty) {
        throw Exception('No image URL for card $cardId');
      }
      final imageBytes = await _apiDatasource.downloadImage(card.imageUrl);
      await _imageLocalDatasource.saveImage(cardId, imageBytes);
    }
    return await _imageLocalDatasource.getImagePath(cardId);
  }

  @override
  Future<bool> isCardImageSaved(int cardId) async {
    return await _imageLocalDatasource.isImageSaved(cardId);
  }
}
