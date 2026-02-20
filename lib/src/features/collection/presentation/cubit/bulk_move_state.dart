import 'package:freezed_annotation/freezed_annotation.dart';

part 'bulk_move_state.freezed.dart';

@freezed
abstract class BulkMoveState with _$BulkMoveState {
  const BulkMoveState._();

  const factory BulkMoveState({
    @Default(false) bool isSelectionMode,
    @Default(<String>{}) Set<String> selectedKeys,
  }) = _BulkMoveState;

  int get selectedCount => selectedKeys.length;
}
