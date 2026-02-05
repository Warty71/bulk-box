import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Cards extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get description => text()();
  TextColumn get race => text()();
  TextColumn get attribute => text().nullable()();
  IntColumn get level => integer().nullable()();
  IntColumn get atk => integer().nullable()();
  IntColumn get def => integer().nullable()();
  TextColumn get imageUrl => text()();
  TextColumn get cardSetsJson => text()();
  @override
  Set<Column> get primaryKey => {id};
}

class Boxes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get color => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// One row per "slot": (card+set+rarity) in a box (or unboxed).
/// Same card can have multiple slots (e.g. 1 in Trade Binder, 2 Unboxed).
class CollectionItems extends Table {
  IntColumn get cardId => integer().references(Cards, #id)();
  TextColumn get setCode => text()();
  TextColumn get setRarity => text()();
  IntColumn get boxId => integer().nullable().references(Boxes, #id)();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  TextColumn get condition => text().nullable()();
  DateTimeColumn get dateAdded => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {cardId, setCode, setRarity, boxId};
}

@DriftDatabase(tables: [Cards, Boxes, CollectionItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Reserved for future schema changes.
        }
        if (from < 3) {
          await m.createTable(boxes);
          await m.addColumn(collectionItems, collectionItems.boxId);
        }
        if (from < 4) {
          // Boxes table may have been created without color (e.g. older build).
          try {
            await m.addColumn(boxes, boxes.color);
          } catch (e) {
            if (!e.toString().contains('duplicate column')) rethrow;
          }
        }
        if (from < 5) {
          // Option B: PK now (cardId, setCode, setRarity, boxId) so same card can be split across boxes.
          await customStatement('''
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
          await customStatement('''
            INSERT INTO collection_items_new (card_id, set_code, set_rarity, box_id, quantity, condition, date_added)
            SELECT card_id, set_code, set_rarity, box_id, quantity, condition, date_added FROM collection_items
          ''');
          await customStatement('DROP TABLE collection_items');
          await customStatement('ALTER TABLE collection_items_new RENAME TO collection_items');
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'bulk_box.db'));
    return NativeDatabase(file);
  });
}
