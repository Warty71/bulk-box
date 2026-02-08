import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/bulk_move_state.dart';

/// Manages selection mode and selected entry keys for bulk move.
/// Enter selection mode via long-press on a card; tap to select/deselect.
class BulkMoveCubit extends Cubit<BulkMoveState> {
  BulkMoveCubit() : super(const BulkMoveState());

  /// Enter selection mode and select the given entry key (e.g. from long-press).
  void enterSelectionMode(String entryKey) {
    emit(state.copyWith(
      isSelectionMode: true,
      selectedKeys: {...state.selectedKeys, entryKey},
    ));
  }

  /// Toggle selection of an entry (tap when in selection mode).
  void toggleSelection(String entryKey) {
    final next = Set<String>.from(state.selectedKeys);
    if (next.contains(entryKey)) {
      next.remove(entryKey);
    } else {
      next.add(entryKey);
    }
    emit(state.copyWith(
      selectedKeys: next,
      isSelectionMode: next.isNotEmpty,
    ));
  }

  /// Select all given keys.
  void selectAll(Iterable<String> keys) {
    emit(state.copyWith(
      selectedKeys: {...state.selectedKeys, ...keys},
      isSelectionMode: true,
    ));
  }

  /// Exit selection mode and clear selection.
  void exitSelectionMode() {
    emit(const BulkMoveState());
  }

  bool isSelected(String entryKey) => state.selectedKeys.contains(entryKey);
}
