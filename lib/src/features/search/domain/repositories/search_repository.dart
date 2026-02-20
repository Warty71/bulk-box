import 'package:bulk_box/src/features/search/domain/entities/card_search_filters.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';

abstract class SearchRepository {
  Future<List<YgoCard>> searchCards(String query, {CardSearchFilters? filters});
}
