import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';

/// One (card + set + rarity) combo in search results.
class SearchResultEntry {
  final YgoCard card;
  final String setName;
  final String setCode;
  final String setRarity;

  SearchResultEntry({
    required this.card,
    required this.setName,
    required this.setCode,
    required this.setRarity,
  });

  /// Unique key for this entry in the cart.
  String get selectionKey => '${card.id}_${setCode}_$setRarity';
}
