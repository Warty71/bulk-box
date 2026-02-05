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

class CollectionItems extends Table {
  IntColumn get cardId => integer().references(Cards, #id)();
  TextColumn get setCode => text()();
  TextColumn get setRarity => text()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  TextColumn get condition => text().nullable()();
  DateTimeColumn get dateAdded => dateTime().withDefault(currentDateAndTime)();
  IntColumn get boxId => integer().nullable().references(Boxes, #id)();

  @override
  Set<Column> get primaryKey => {cardId, setCode, setRarity};
}

@DriftDatabase(tables: [Cards, Boxes, CollectionItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

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
