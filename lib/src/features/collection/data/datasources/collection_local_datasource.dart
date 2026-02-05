import 'package:drift/drift.dart';
import 'package:bulk_box/src/core/database/app_database.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_item.dart';

class CollectionLocalDatasource {
  final AppDatabase _db;

  CollectionLocalDatasource(this._db);

  /// [boxId] null = all slots; [unboxedOnly] true = only slots with no box.
  Future<List<CollectionEntry>> getCollectionWithCards({
    int? boxId,
    bool unboxedOnly = false,
  }) async {
    var query = _db.select(_db.collectionItems).join([
      innerJoin(_db.cards, _db.cards.id.equalsExp(_db.collectionItems.cardId)),
      leftOuterJoin(
          _db.boxes, _db.boxes.id.equalsExp(_db.collectionItems.boxId)),
    ]);
    if (unboxedOnly) {
      query = query..where(_db.collectionItems.boxId.isNull());
    } else if (boxId != null) {
      query = query..where(_db.collectionItems.boxId.equals(boxId));
    }
    return await query.map((row) {
      final item = row.readTable(_db.collectionItems);
      final card = row.readTable(_db.cards);
      final box = row.readTableOrNull(_db.boxes);
      return CollectionEntry(
        card: card,
        setCode: item.setCode,
        setRarity: item.setRarity,
        quantity: item.quantity,
        condition: item.condition,
        dateAdded: item.dateAdded,
        boxId: item.boxId,
        boxName: box?.name,
      );
    }).get();
  }

  /// All slots (one per card+set+rarity+box).
  Future<List<CollectionItemEntity>> getAllCollectionItems() async {
    final items = await (_db.select(_db.collectionItems)).get();
    return items.map(_mapToEntity).toList();
  }

  /// All slots for a card (any set/rarity).
  Future<List<CollectionItemEntity>> getCollectionItemsByCardId(
    int cardId,
  ) async {
    final items = await (_db.select(_db.collectionItems)
          ..where((tbl) => tbl.cardId.equals(cardId)))
        .get();
    return items.map(_mapToEntity).toList();
  }

  /// All slots for one card+set+rarity (e.g. "3 copies" = 3 slots: Trade Binder 1, Unboxed 2).
  Future<List<CollectionItemEntity>> getSlotsForCard(
    int cardId,
    String setCode,
    String setRarity,
  ) async {
    final items = await (_db.select(_db.collectionItems)
          ..where((tbl) =>
              tbl.cardId.equals(cardId) &
              tbl.setCode.equals(setCode) &
              tbl.setRarity.equals(setRarity)))
        .get();
    return items.map(_mapToEntity).toList();
  }

  /// One slot by full key.
  Future<CollectionItemEntity?> getSlot(
    int cardId,
    String setCode,
    String setRarity,
    int? boxId,
  ) async {
    final q = _db.select(_db.collectionItems)
      ..where((tbl) =>
          tbl.cardId.equals(cardId) &
          tbl.setCode.equals(setCode) &
          tbl.setRarity.equals(setRarity) &
          (boxId == null ? tbl.boxId.isNull() : tbl.boxId.equals(boxId)));
    final item = await q.getSingleOrNull();
    return item != null ? _mapToEntity(item) : null;
  }

  /// Insert or increment slot for (cardId, setCode, setRarity, boxId).
  Future<void> insertOrUpdateCollectionItem(
    CollectionItemEntity item,
  ) async {
    final existing = await getSlot(
      item.cardId,
      item.setCode,
      item.setRarity,
      item.boxId,
    );

    if (existing != null) {
      await (_db.update(_db.collectionItems)
            ..where((tbl) =>
                tbl.cardId.equals(item.cardId) &
                tbl.setCode.equals(item.setCode) &
                tbl.setRarity.equals(item.setRarity) &
                (item.boxId == null
                    ? tbl.boxId.isNull()
                    : tbl.boxId.equals(item.boxId!))))
          .write(CollectionItemsCompanion(
        quantity: Value(existing.quantity + item.quantity),
      ));
    } else {
      await _db.into(_db.collectionItems).insert(
            CollectionItemsCompanion(
              cardId: Value(item.cardId),
              setCode: Value(item.setCode),
              setRarity: Value(item.setRarity),
              quantity: Value(item.quantity),
              condition: Value(item.condition),
              dateAdded: Value(item.dateAdded),
              boxId: Value(item.boxId),
            ),
          );
    }
  }

  /// Update quantity for one slot; delete if quantity <= 0.
  Future<void> updateSlotQuantity(
    int cardId,
    String setCode,
    String setRarity,
    int? boxId,
    int quantity,
  ) async {
    if (quantity <= 0) {
      await deleteSlot(cardId, setCode, setRarity, boxId);
      return;
    }

    await (_db.update(_db.collectionItems)
          ..where((tbl) =>
              tbl.cardId.equals(cardId) &
              tbl.setCode.equals(setCode) &
              tbl.setRarity.equals(setRarity) &
              (boxId == null ? tbl.boxId.isNull() : tbl.boxId.equals(boxId))))
        .write(CollectionItemsCompanion(quantity: Value(quantity)));
  }

  /// Delete one slot.
  Future<void> deleteSlot(
    int cardId,
    String setCode,
    String setRarity,
    int? boxId,
  ) async {
    await (_db.delete(_db.collectionItems)
          ..where((tbl) =>
              tbl.cardId.equals(cardId) &
              tbl.setCode.equals(setCode) &
              tbl.setRarity.equals(setRarity) &
              (boxId == null ? tbl.boxId.isNull() : tbl.boxId.equals(boxId))))
        .go();
  }

  /// Move [amount] from one slot to another (or create destination slot).
  Future<void> moveBetweenSlots(
    int cardId,
    String setCode,
    String setRarity,
    int? fromBoxId,
    int? toBoxId,
    int amount,
  ) async {
    if (amount <= 0 || (fromBoxId == toBoxId)) return;

    final from = await getSlot(cardId, setCode, setRarity, fromBoxId);
    if (from == null || from.quantity < amount) return;

    final newFromQty = from.quantity - amount;
    if (newFromQty <= 0) {
      await deleteSlot(cardId, setCode, setRarity, fromBoxId);
    } else {
      await updateSlotQuantity(
          cardId, setCode, setRarity, fromBoxId, newFromQty);
    }

    final to = await getSlot(cardId, setCode, setRarity, toBoxId);
    if (to != null) {
      await updateSlotQuantity(
          cardId, setCode, setRarity, toBoxId, to.quantity + amount);
    } else {
      await insertOrUpdateCollectionItem(
        CollectionItemEntity(
          cardId: cardId,
          setCode: setCode,
          setRarity: setRarity,
          quantity: amount,
          dateAdded: from.dateAdded,
          boxId: toBoxId,
        ),
      );
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
      boxId: item.boxId,
    );
  }
}
