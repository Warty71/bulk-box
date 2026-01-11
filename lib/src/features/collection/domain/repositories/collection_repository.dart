import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';

abstract class CollectionRepository {
  /// Get all collection items
  Future<List<CollectionItemEntity>> getAllCollectionItems();

  /// Get collection items for a specific card
  Future<List<CollectionItemEntity>> getCollectionItemsByCardId(int cardId);

  /// Get a specific collection item by cardId, setCode, and setRarity
  Future<CollectionItemEntity?> getCollectionItem(
    int cardId,
    String setCode,
    String setRarity,
  );

  /// Add or update a collection item (increment quantity if exists)
  Future<void> addCollectionItem(CollectionItemEntity item);

  /// Update quantity of a collection item
  Future<void> updateQuantity(
    int cardId,
    String setCode,
    String setRarity,
    int quantity,
  );

  /// Remove a collection item (or decrease quantity)
  Future<void> removeCollectionItem(
    int cardId,
    String setCode,
    String setRarity,
  );

  /// Delete a collection item completely
  Future<void> deleteCollectionItem(
    int cardId,
    String setCode,
    String setRarity,
  );
}
