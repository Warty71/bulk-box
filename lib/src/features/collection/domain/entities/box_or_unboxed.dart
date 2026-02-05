import 'package:bulk_box/src/features/collection/domain/entities/box.dart';

/// Represents either "Unboxed" or a specific [Box] (e.g. for navigation or grid items).
class BoxOrUnboxed {
  final bool isUnboxed;
  final Box? box;

  BoxOrUnboxed._({required this.isUnboxed, this.box});

  factory BoxOrUnboxed.unboxed() => BoxOrUnboxed._(isUnboxed: true);

  factory BoxOrUnboxed.box(Box box) =>
      BoxOrUnboxed._(isUnboxed: false, box: box);
}
