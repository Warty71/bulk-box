import 'package:ygo_collector/src/core/database/app_database.dart';

class CollectionEntry {
  final Card card; // Full card data
  final String setCode; // Which set user owns
  final String setRarity; // Rarity of owned copy
  final int quantity;
  final String? condition;
  final DateTime dateAdded;

  CollectionEntry({
    required this.card,
    required this.setCode,
    required this.setRarity,
    required this.quantity,
    required this.condition,
    required this.dateAdded,
  });
}
