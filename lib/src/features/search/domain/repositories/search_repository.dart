import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';

abstract class SearchRepository {
  Future<List<YgoCard>> searchCards(String query);
  Future<List<YgoCard>> searchCardsLocal(String query);
}
