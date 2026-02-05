import 'package:bulk_box/src/core/database/app_database.dart';

class CollectionEntry {
  final Card card; // Full card data
  final String setCode; // Which set user owns
  final String setRarity; // Rarity of owned copy
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
}
