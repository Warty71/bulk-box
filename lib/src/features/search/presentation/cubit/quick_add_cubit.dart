import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_item.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/collection_repository.dart';
import 'package:bulk_box/src/features/search/domain/entities/search_result_entry.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_state.dart';
import 'package:bulk_box/src/features/ygo_cards/data/mappers/card_model_mapper.dart';

/// Manages the staging cart for quick-adding cards from search.
class QuickAddCubit extends Cubit<QuickAddState> {
  final CardDao _cardDao;
  final CollectionRepository _collectionRepository;

  QuickAddCubit(this._cardDao, this._collectionRepository)
      : super(const QuickAddState());

  /// Set quantity for an entry. Creates the item if needed, removes if 0.
  void setQuantity(SearchResultEntry entry, int quantity) {
    final key = entry.selectionKey;
    final next = Map<String, QuickAddItem>.from(state.cart);

    if (quantity <= 0) {
      next.remove(key);
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

    emit(state.copyWith(cart: next));
  }

  /// Remove an item entirely from the cart.
  void removeItem(String selectionKey) {
    final next = Map<String, QuickAddItem>.from(state.cart);
    next.remove(selectionKey);
    emit(state.copyWith(cart: next));
  }

  /// Update quantity for an entry by selection key.
  void updateQuantity(String selectionKey, int quantity) {
    final item = state.cart[selectionKey];
    if (item == null) return;

    final next = Map<String, QuickAddItem>.from(state.cart);

    if (quantity <= 0) {
      next.remove(selectionKey);
    } else {
      next[selectionKey] = item.copyWith(quantity: quantity);
    }

    emit(state.copyWith(cart: next));
  }

  /// Clear the entire cart.
  void clearCart() {
    emit(const QuickAddState());
  }

  /// Batch add all cart items to collection, then clear cart.
  Future<void> confirmAdd({required int? boxId}) async {
    final now = DateTime.now();

    for (final item in state.cart.values) {
      // Ensure card row exists in DB for foreign key integrity
      await _cardDao.insertOrUpdateCards(
        [CardModelMapper.toDriftCard(item.card)],
      );

      await _collectionRepository.addCollectionItem(
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

    clearCart();
  }
}
