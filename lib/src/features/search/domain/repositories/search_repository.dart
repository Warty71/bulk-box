import 'package:ygo_collector/src/features/ygo_cards/data/entities/ygo_card.dart';

abstract class SearchRepository {
  Future<List<YgoCard>> searchCards(String query);
  Future<String> getCardImagePath(int cardId);
  Future<bool> isCardImageSaved(int cardId);
}
