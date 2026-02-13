import 'package:bulk_box/src/core/database/app_database.dart';
import 'package:flutter/foundation.dart';

class QuickAddItem {
  final Card card;
  final String setCode;
  final String setRarity;
  final int quantity;

  const QuickAddItem({
    required this.card,
    required this.setCode,
    required this.setRarity,
    required this.quantity,
  });

  QuickAddItem copyWith({int? quantity}) {
    return QuickAddItem(
      card: card,
      setCode: setCode,
      setRarity: setRarity,
      quantity: quantity ?? this.quantity,
    );
  }
}

class QuickAddState {
  final Map<String, QuickAddItem> cart;
  final String? selectedKey;

  const QuickAddState({
    this.cart = const {},
    this.selectedKey,
  });

  int get totalCount =>
      cart.values.fold(0, (sum, item) => sum + item.quantity);

  bool get hasItems => cart.isNotEmpty;

  bool get hasSelection => selectedKey != null;

  bool get barVisible => hasSelection || hasItems;

  QuickAddItem? get selectedItem =>
      selectedKey != null ? cart[selectedKey] : null;

  int quantityFor(String selectionKey) =>
      cart[selectionKey]?.quantity ?? 0;

  bool isSelected(String selectionKey) => selectedKey == this.selectedKey;

  QuickAddState copyWith({
    Map<String, QuickAddItem>? cart,
    String? selectedKey,
  }) {
    return QuickAddState(
      cart: cart ?? this.cart,
      selectedKey: selectedKey ?? this.selectedKey,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickAddState &&
          runtimeType == other.runtimeType &&
          mapEquals(cart, other.cart);

  @override
  int get hashCode => Object.hashAll(cart.entries);
}
