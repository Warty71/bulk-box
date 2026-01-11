import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class CollectionItems extends Table {
  IntColumn get cardId => integer()();
  TextColumn get cardName => text()();
  TextColumn get setCode => text()();
  TextColumn get setRarity => text()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  TextColumn get condition => text().nullable()();
  DateTimeColumn get dateAdded => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {cardId, setCode, setRarity};
}

@DriftDatabase(tables: [CollectionItems])
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
    final file = File(p.join(dbFolder.path, 'ygo_collector.db'));
    return NativeDatabase(file);
  });
}
