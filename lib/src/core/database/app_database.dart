import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'migrations/app_migrations.dart';

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
class AppDatabase extends _$AppDatabase implements MigrationDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        await runMigrations(m, from, to, this);
      },
    );
  }

  @override
  Future<void> runCustomStatement(String sql) => customStatement(sql);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'bulk_box.db'));
    return NativeDatabase(file);
  });
}
