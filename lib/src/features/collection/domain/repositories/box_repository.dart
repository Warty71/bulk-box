import 'package:bulk_box/src/features/collection/domain/entities/box.dart';

abstract class BoxRepository {
  Future<List<Box>> getBoxes();

  Future<Box?> getBoxById(int id);

  Future<int> createBox({required String name, String? color});

  Future<void> updateBox(int id, {String? name, String? color, int? sortOrder});

  /// Deletes the box and moves all its items to unboxed.
  Future<void> deleteBox(int id);

  Future<int> countItemsInBox(int id);
}
