import 'package:flutter/material.dart';

enum CollectionViewMode {
  list,
  grid,
}

extension CollectionViewModeX on CollectionViewMode {
  bool get isList => this == CollectionViewMode.list;
  bool get isGrid => this == CollectionViewMode.grid;

  CollectionViewMode get toggled => this == CollectionViewMode.list
      ? CollectionViewMode.grid
      : CollectionViewMode.list;

  IconData get icon {
    switch (this) {
      case CollectionViewMode.list:
        return Icons.grid_view;
      case CollectionViewMode.grid:
        return Icons.list;
    }
  }

  String get tooltip {
    switch (this) {
      case CollectionViewMode.list:
        return 'Grid view';
      case CollectionViewMode.grid:
        return 'List view';
    }
  }
}
