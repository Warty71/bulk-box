import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_item.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/search/domain/entities/search_result_entry.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_state.dart';

/// Manages the staging cart for quick-adding cards from search.
class QuickAddCubit extends Cubit<QuickAddState> {
  final CardDao _cardDao;

  QuickAddCubit(this._cardDao) : super(const QuickAddState());

  /// Set quantity for an entry. Creates the item if needed, removes if 0.
  void setQuantity(SearchResultEntry entry, int quantity) {
    final key = entry.selectionKey;
    final next = Map<String, QuickAddItem>.from(state.cart);
    String? newSelectedKey = state.selectedKey;

    if (quantity <= 0) {
      next.remove(key);
      // Clear selection if the removed item was selected
      if (newSelectedKey == key) {
        newSelectedKey = null;
      }
    } else {
      final existing = next[key];
      if (existing != null) {
        next[key] = existing.copyWith(quantity: quantity);
      } else {
        next[key] = QuickAddItem(
          card: entry.card,
          setCode: entry.setCode,
          setRarity: entry.setRarity,
          quantity: quantity,
        );
      }
    }

    emit(state.copyWith(cart: next, selectedKey: newSelectedKey));
  }

  /// Remove an item entirely from the cart.
  void removeItem(String selectionKey) {
    final next = Map<String, QuickAddItem>.from(state.cart);
    next.remove(selectionKey);
    String? newSelectedKey = state.selectedKey;
    // Clear selection if the removed item was selected
    if (newSelectedKey == selectionKey) {
      newSelectedKey = null;
    }
    emit(state.copyWith(cart: next, selectedKey: newSelectedKey));
  }

  /// Select an entry (for showing in the selection bar).
  void selectEntry(SearchResultEntry entry) {
    final key = entry.selectionKey;
    // If already selected, deselect. Otherwise, select it.
    final newSelectedKey = state.selectedKey == key ? null : key;
    emit(state.copyWith(selectedKey: newSelectedKey));
  }

  /// Update quantity for an entry by selection key (used by selection bar).
  void updateQuantity(String selectionKey, int quantity) {
    final item = state.cart[selectionKey];
    if (item == null) return;

    final next = Map<String, QuickAddItem>.from(state.cart);
    String? newSelectedKey = state.selectedKey;

    if (quantity <= 0) {
      next.remove(selectionKey);
      // Clear selection if the removed item was selected
      if (newSelectedKey == selectionKey) {
        newSelectedKey = null;
      }
    } else {
      next[selectionKey] = item.copyWith(quantity: quantity);
    }

    emit(state.copyWith(cart: next, selectedKey: newSelectedKey));
  }

  /// Clear the entire cart and selection.
  void clearCart() {
    emit(const QuickAddState());
  }

  /// Batch add all cart items to collection, then clear cart.
  Future<void> confirmAdd({
    required int? boxId,
    required CollectionCubit collectionCubit,
    required BoxesCubit boxesCubit,
  }) async {
    final now = DateTime.now();

    for (final item in state.cart.values) {
      await _cardDao.insertOrUpdateCards([item.card]);

      await collectionCubit.addCollectionItem(
        CollectionItemEntity(
          cardId: item.card.id,
          setCode: item.setCode,
          setRarity: item.setRarity,
          quantity: item.quantity,
          dateAdded: now,
          boxId: boxId,
        ),
      );
    }

    await boxesCubit.loadBoxes();
    clearCart();
  }
}
