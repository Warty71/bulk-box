abstract class ImageRepository {
  Future<String> getCardImagePath(int cardId);
  Future<bool> isCardImageSaved(int cardId);
}
