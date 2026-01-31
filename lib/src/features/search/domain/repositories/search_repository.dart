import 'package:ygo_collector/src/core/database/app_database.dart';

abstract class SearchRepository {
  Future<List<Card>> searchCards(String query);
  Future<String> getCardImagePath(int cardId);
  Future<bool> isCardImageSaved(int cardId);
}
