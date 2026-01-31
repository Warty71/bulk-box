import 'package:bulk_box/src/core/database/app_database.dart';

abstract class CardRepository {
  Future<List<Card>> searchCards(String query);
  Future<Card> getCardDetails(int cardId);
  Future<String> getLocalImagePath(int cardId);
  Future<void> saveCardImage(int cardId, List<int> imageBytes);
  Future<bool> isCardImageSaved(int cardId);
}
