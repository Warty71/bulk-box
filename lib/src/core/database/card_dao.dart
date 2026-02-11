import 'package:drift/drift.dart';
import 'package:bulk_box/src/core/database/app_database.dart';

class CardDao {
  final AppDatabase _db;

  CardDao(this._db);

  Future<void> insertOrUpdateCards(List<Card> cards) async {
    await _db.batch((batch) {
      for (final card in cards) {
        batch.insert(
          _db.cards,
          card,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<Card?> getCardById(int id) async {
    return await (_db.select(_db.cards)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<Card>> getCardsByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    return await (_db.select(_db.cards)..where((tbl) => tbl.id.isIn(ids)))
        .get();
  }

  Future<List<Card>> searchCardsByName(String query) async {
    final pattern = '%${query.toLowerCase()}%';
    return await (_db.select(_db.cards)..where((tbl) => tbl.name.like(pattern)))
        .get();
  }

  Future<List<int>> getCardIdsWithoutArchetype() async {
    final rows = await (_db.select(_db.cards)
          ..where((tbl) => tbl.archetype.isNull()))
        .get();
    return rows.map((r) => r.id).toList();
  }
}
