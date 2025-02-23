import 'package:ygo_collector/src/core/ygo_cards/data/entities/ygo_card.dart';

abstract class CardRepository {
  Future<List<YgoCard>> searchCards(String query);
  Future<YgoCard> getCardDetails(int cardId);
  Future<String> getLocalImagePath(int cardId);
  Future<void> saveCardImage(int cardId, List<int> imageBytes);
  Future<bool> isCardImageSaved(int cardId);
}
