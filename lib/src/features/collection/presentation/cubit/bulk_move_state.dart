import 'package:flutter/foundation.dart';

/// State for bulk move selection mode on the collection grid.
class BulkMoveState {
  const BulkMoveState({
    this.isSelectionMode = false,
    Set<String>? selectedKeys,
  }) : selectedKeys = selectedKeys ?? const {};

  final bool isSelectionMode;
  final Set<String> selectedKeys;

  int get selectedCount => selectedKeys.length;

  BulkMoveState copyWith({
    bool? isSelectionMode,
    Set<String>? selectedKeys,
  }) {
    return BulkMoveState(
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      selectedKeys: selectedKeys ?? this.selectedKeys,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BulkMoveState &&
          isSelectionMode == other.isSelectionMode &&
          setEquals(selectedKeys, other.selectedKeys);

  @override
  int get hashCode => Object.hash(
        isSelectionMode,
        Object.hashAllUnordered(selectedKeys),
      );
}
