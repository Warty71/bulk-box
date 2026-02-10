import 'package:drift/drift.dart';

/// Minimal interface for running migrations without depending on [AppDatabase].
/// Implemented by [AppDatabase] to avoid circular imports.
abstract class MigrationDatabase {
  Future<void> runCustomStatement(String sql);
  dynamic get boxes;
  dynamic get cards;
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
  if (from < 3) await _migrateV2ToV3(m, db);
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

Future<void> _migrateV2ToV3(Migrator m, MigrationDatabase db) async {
  // v2 → v3: add frameType column to cards table and backfill from type.
  await m.addColumn(db.cards, db.cards.frameType);
  await db.runCustomStatement('''
    UPDATE cards SET frame_type = CASE
      WHEN type LIKE '%Pendulum%' THEN CASE
        WHEN type LIKE '%Synchro%'  THEN 'synchro_pendulum'
        WHEN type LIKE '%XYZ%'      THEN 'xyz_pendulum'
        WHEN type LIKE '%Fusion%'   THEN 'fusion_pendulum'
        WHEN type LIKE '%Ritual%'   THEN 'ritual_pendulum'
        WHEN type LIKE '%Normal%'   THEN 'normal_pendulum'
        ELSE 'effect_pendulum'
      END
      WHEN type = 'Spell Card'      THEN 'spell'
      WHEN type = 'Trap Card'       THEN 'trap'
      WHEN type LIKE '%Token%'      THEN 'token'
      WHEN type LIKE '%Skill%'      THEN 'skill'
      WHEN type LIKE '%Link%'       THEN 'link'
      WHEN type LIKE '%XYZ%'        THEN 'xyz'
      WHEN type LIKE '%Synchro%'    THEN 'synchro'
      WHEN type LIKE '%Fusion%'     THEN 'fusion'
      WHEN type LIKE '%Ritual%'     THEN 'ritual'
      WHEN type = 'Normal Monster'  THEN 'normal'
      ELSE 'effect'
    END
    WHERE frame_type IS NULL
  ''');
}
