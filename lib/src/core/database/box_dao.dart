import 'package:drift/drift.dart';
import 'package:bulk_box/src/core/database/app_database.dart';

class BoxDao {
  final AppDatabase _db;

  BoxDao(this._db);

  Future<List<Boxe>> getAllBoxes() async {
    return await (_db.select(_db.boxes)
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder), (t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  Future<Boxe?> getBoxById(int id) async {
    return await (_db.select(_db.boxes)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> insertBox(BoxesCompanion companion) async {
    return await _db.into(_db.boxes).insert(companion);
  }

  Future<void> updateBox(int id, BoxesCompanion companion) async {
    await (_db.update(_db.boxes)..where((tbl) => tbl.id.equals(id)))
        .write(companion);
  }

  Future<void> deleteBox(int id) async {
    await (_db.delete(_db.boxes)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Move all items in this box to unboxed (set boxId to null).
  Future<void> unassignAllItemsFromBox(int boxId) async {
    await (_db.update(_db.collectionItems)
          ..where((tbl) => tbl.boxId.equals(boxId)))
        .write(const CollectionItemsCompanion(boxId: Value(null)));
  }

  Future<int> countItemsInBox(int boxId) async {
    final result = await (_db.selectOnly(_db.collectionItems)
          ..addColumns([_db.collectionItems.quantity.sum()])
          ..where(_db.collectionItems.boxId.equals(boxId)))
        .getSingle();
    final sum = result.read(_db.collectionItems.quantity.sum());
    return sum ?? 0;
  }
}
