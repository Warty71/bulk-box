import 'package:drift/drift.dart';
import 'package:ygo_collector/src/core/database/app_database.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_entry.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';

class CollectionLocalDatasource {
  final AppDatabase _db;

  CollectionLocalDatasource(this._db);

  Future<List<CollectionEntry>> getCollectionWithCards() async {
    final query = _db.select(_db.collectionItems).join([
      innerJoin(_db.cards, _db.cards.id.equalsExp(_db.collectionItems.cardId)),
    ]);
    return await query.map((row) {
      final item = row.readTable(_db.collectionItems);
      final card = row.readTable(_db.cards);
      return CollectionEntry(
        card: card,
        setCode: item.setCode,
        setRarity: item.setRarity,
        quantity: item.quantity,
        condition: item.condition,
        dateAdded: item.dateAdded,
      );
    }).get();
  }

  /// Get all collection items
  Future<List<CollectionItemEntity>> getAllCollectionItems() async {
    final items = await (_db.select(_db.collectionItems)).get();
    return items.map(_mapToEntity).toList();
  }

  /// Get collection items for a specific card
  Future<List<CollectionItemEntity>> getCollectionItemsByCardId(
    int cardId,
  ) async {
    final items = await (_db.select(_db.collectionItems)
          ..where((tbl) => tbl.cardId.equals(cardId)))
        .get();
    return items.map(_mapToEntity).toList();
  }

  /// Get a specific collection item
  Future<CollectionItemEntity?> getCollectionItem(
    int cardId,
    String setCode,
    String setRarity,
  ) async {
    final item = await (_db.select(_db.collectionItems)
          ..where((tbl) =>
              tbl.cardId.equals(cardId) &
              tbl.setCode.equals(setCode) &
              tbl.setRarity.equals(setRarity)))
        .getSingleOrNull();
    return item != null ? _mapToEntity(item) : null;
  }

  /// Insert or update a collection item (increment quantity if exists)
  Future<void> insertOrUpdateCollectionItem(
    CollectionItemEntity item,
  ) async {
    final existing = await getCollectionItem(
      item.cardId,
      item.setCode,
      item.setRarity,
    );

    if (existing != null) {
      // Update quantity
      await (_db.update(_db.collectionItems)
            ..where((tbl) =>
                tbl.cardId.equals(item.cardId) &
                tbl.setCode.equals(item.setCode) &
                tbl.setRarity.equals(item.setRarity)))
          .write(CollectionItemsCompanion(
        quantity: Value(existing.quantity + item.quantity),
      ));
    } else {
      // Insert new
      await _db.into(_db.collectionItems).insert(
            CollectionItemsCompanion(
              cardId: Value(item.cardId),
              setCode: Value(item.setCode),
              setRarity: Value(item.setRarity),
              quantity: Value(item.quantity),
              condition: Value(item.condition),
            ),
          );
    }
  }

  /// Update quantity of a collection item
  Future<void> updateQuantity(
    int cardId,
    String setCode,
    String setRarity,
    int quantity,
  ) async {
    if (quantity <= 0) {
      await deleteCollectionItem(cardId, setCode, setRarity);
      return;
    }

    await (_db.update(_db.collectionItems)
          ..where((tbl) =>
              tbl.cardId.equals(cardId) &
              tbl.setCode.equals(setCode) &
              tbl.setRarity.equals(setRarity)))
        .write(CollectionItemsCompanion(
      quantity: Value(quantity),
    ));
  }

  /// Delete a collection item
  Future<void> deleteCollectionItem(
    int cardId,
    String setCode,
    String setRarity,
  ) async {
    await (_db.delete(_db.collectionItems)
          ..where((tbl) =>
              tbl.cardId.equals(cardId) &
              tbl.setCode.equals(setCode) &
              tbl.setRarity.equals(setRarity)))
        .go();
  }

  /// Decrease quantity by 1 (or delete if quantity becomes 0)
  Future<void> decreaseQuantity(
    int cardId,
    String setCode,
    String setRarity,
  ) async {
    final existing = await getCollectionItem(cardId, setCode, setRarity);
    if (existing == null) return;

    final newQuantity = existing.quantity - 1;
    if (newQuantity <= 0) {
      await deleteCollectionItem(cardId, setCode, setRarity);
    } else {
      await updateQuantity(cardId, setCode, setRarity, newQuantity);
    }
  }

  CollectionItemEntity _mapToEntity(CollectionItem item) {
    return CollectionItemEntity(
      cardId: item.cardId,
      setCode: item.setCode,
      setRarity: item.setRarity,
      quantity: item.quantity,
      condition: item.condition,
      dateAdded: item.dateAdded,
    );
  }
}
