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

class CollectionItems extends Table {
  IntColumn get cardId => integer().references(Cards, #id)();
  TextColumn get setCode => text()();
  TextColumn get setRarity => text()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  TextColumn get condition => text().nullable()();
  DateTimeColumn get dateAdded => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {cardId, setCode, setRarity};
}

@DriftDatabase(tables: [Cards, CollectionItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
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
