import 'package:drift/drift.dart';
import 'package:bulk_box/src/core/database/app_database.dart';
import 'package:bulk_box/src/core/database/box_dao.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/box_repository.dart';

class BoxRepositoryImpl implements BoxRepository {
  final BoxDao _boxDao;

  BoxRepositoryImpl(this._boxDao);

  @override
  Future<List<Box>> getBoxes() async {
    final rows = await _boxDao.getAllBoxes();
    return rows.map(_toBox).toList();
  }

  @override
  Future<Box?> getBoxById(int id) async {
    final row = await _boxDao.getBoxById(id);
    return row != null ? _toBox(row) : null;
  }

  @override
  Future<int> createBox({required String name, String? color}) async {
    return await _boxDao.insertBox(
      BoxesCompanion.insert(
        name: name,
        color: Value(color),
      ),
    );
  }

  @override
  Future<void> updateBox(int id,
      {String? name, String? color, int? sortOrder}) async {
    await _boxDao.updateBox(
      id,
      BoxesCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        color: color != null ? Value(color) : const Value.absent(),
        sortOrder: sortOrder != null ? Value(sortOrder) : const Value.absent(),
      ),
    );
  }

  @override
  Future<void> deleteBox(int id) async {
    await _boxDao.unassignAllItemsFromBox(id);
    await _boxDao.deleteBox(id);
  }

  @override
  Future<int> countItemsInBox(int id) async {
    return await _boxDao.countItemsInBox(id);
  }

  Box _toBox(Boxe row) {
    return Box(
      id: row.id,
      name: row.name,
      color: row.color,
      sortOrder: row.sortOrder,
      createdAt: row.createdAt,
    );
  }
}
