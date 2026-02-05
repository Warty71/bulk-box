import 'package:drift/drift.dart';

/// Minimal interface for running migrations without depending on [AppDatabase].
/// Implemented by [AppDatabase] to avoid circular imports.
abstract class MigrationDatabase {
  Future<void> runCustomStatement(String sql);
  dynamic get boxes;
  dynamic get collectionItems;
}

/// Runs all pending migrations from [from] to [to].
Future<void> runMigrations(
  Migrator m,
  int from,
  int to,
  MigrationDatabase db,
) async {
  if (from < 2) await _migrateV1ToV2(m, db);
}

Future<void> _migrateV1ToV2(Migrator m, MigrationDatabase db) async {
  // v1 → v2: boxes feature (TestFlight was on v1; all dev steps collapsed here).
  await m.createTable(db.boxes);
  await m.addColumn(db.collectionItems, db.collectionItems.boxId);
  try {
    await m.addColumn(db.boxes, db.boxes.color);
  } catch (e) {
    if (!e.toString().contains('duplicate column')) rethrow;
  }
  await db.runCustomStatement('''
    CREATE TABLE collection_items_new (
      card_id INTEGER NOT NULL REFERENCES cards(id),
      set_code TEXT NOT NULL,
      set_rarity TEXT NOT NULL,
      box_id INTEGER REFERENCES boxes(id),
      quantity INTEGER NOT NULL DEFAULT 1,
      condition TEXT,
      date_added INTEGER NOT NULL,
      PRIMARY KEY (card_id, set_code, set_rarity, box_id)
    )
  ''');
  await db.runCustomStatement('''
    INSERT INTO collection_items_new (card_id, set_code, set_rarity, box_id, quantity, condition, date_added)
    SELECT card_id, set_code, set_rarity, box_id, quantity, condition, date_added FROM collection_items
  ''');
  await db.runCustomStatement('DROP TABLE collection_items');
  await db.runCustomStatement('ALTER TABLE collection_items_new RENAME TO collection_items');
}
