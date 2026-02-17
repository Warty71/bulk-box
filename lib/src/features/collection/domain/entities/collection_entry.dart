import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';

class CollectionEntry {
  final YgoCard card;
  final String setCode;
  final String setRarity;
  final int quantity;
  final String? condition;
  final DateTime dateAdded;
  /// Box this item is in; null means unboxed.
  final int? boxId;
  /// Box name for display; null when unboxed.
  final String? boxName;

  CollectionEntry({
    required this.card,
    required this.setCode,
    required this.setRarity,
    required this.quantity,
    required this.condition,
    required this.dateAdded,
    this.boxId,
    this.boxName,
  });

  /// Unique key for this slot (card + set + rarity + box). Used for bulk selection.
  String get selectionKey =>
      '${card.id}_${setCode}_${setRarity}_${boxId ?? 'u'}';
}
