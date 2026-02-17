import 'package:flutter/foundation.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';

class QuickAddItem {
  final YgoCard card;
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

  const QuickAddState({this.cart = const {}});

  int get totalCount =>
      cart.values.fold(0, (sum, item) => sum + item.quantity);

  bool get hasItems => cart.isNotEmpty;

  int quantityFor(String selectionKey) =>
      cart[selectionKey]?.quantity ?? 0;

  QuickAddState copyWith({Map<String, QuickAddItem>? cart}) {
    return QuickAddState(cart: cart ?? this.cart);
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
