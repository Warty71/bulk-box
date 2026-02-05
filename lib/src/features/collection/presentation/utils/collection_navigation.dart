import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';

/// Navigation helpers for collection/box routes.
extension CollectionNavigation on BuildContext {
  /// Pushes the collection box view (or Unboxed). Back returns to previous screen.
  void pushCollectionBox(Box? box) {
    if (box == null) {
      push('/collection/box/unboxed');
    } else {
      push(
        '/collection/box/${box.id}?name=${Uri.encodeComponent(box.name)}',
      );
    }
  }

  /// Replaces current route with the collection box view (or Unboxed).
  void goCollectionBox(Box? box) {
    if (box == null) {
      go('/collection/box/unboxed');
    } else {
      go(
        '/collection/box/${box.id}?name=${Uri.encodeComponent(box.name)}',
      );
    }
  }
}
