import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item_with_card.dart';
import 'package:ygo_collector/src/features/collection/domain/repositories/collection_repository.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_state.dart';
import 'package:ygo_collector/src/features/sorting/domain/comparators/ygo_card_sorters.dart';
import 'package:ygo_collector/src/features/sorting/domain/entities/sort_options.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/datasources/local/card_local_datasource.dart';

class CollectionCubit extends Cubit<CollectionState> {
  final CollectionRepository _repository;
  final CardLocalDatasource _cardDatasource;
  CollectionCubit(this._repository, this._cardDatasource)
      : super(const CollectionState.initial());

  /// Load all collection items
  Future<void> loadCollectionItems() async {
    emit(const CollectionState.loading());

    try {
      final collectionItems = await _repository.getAllCollectionItems();

      // Fetch cards for each item
      final itemsWithCards = await Future.wait(
        collectionItems.map((ci) async {
          final card = await _cardDatasource.getCardById(ci.cardId);
          if (card == null) return null;
          return CollectionItemWithCard(item: ci, card: card);
        }),
      );

      final finalItems = itemsWithCards
          .where((e) => e != null)
          .cast<CollectionItemWithCard>()
          .toList();

      emit(CollectionState.loaded(itemsWithCards: finalItems));
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }

  /// Add a collection item
  Future<void> addCollectionItem(CollectionItemEntity item) async {
    try {
      await _repository.addCollectionItem(item);
      await loadCollectionItems();
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }

  /// Update quantity of a collection item
  Future<void> updateQuantity(
    int cardId,
    String setCode,
    String setRarity,
    int quantity,
  ) async {
    try {
      await _repository.updateQuantity(cardId, setCode, setRarity, quantity);
      await loadCollectionItems();
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }

  /// Remove one quantity from a collection item
  Future<void> removeCollectionItem(
    int cardId,
    String setCode,
    String setRarity,
  ) async {
    try {
      await _repository.removeCollectionItem(cardId, setCode, setRarity);
      await loadCollectionItems();
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }

  /// Delete a collection item completely
  Future<void> deleteCollectionItem(
    int cardId,
    String setCode,
    String setRarity,
  ) async {
    try {
      await _repository.deleteCollectionItem(cardId, setCode, setRarity);
      await loadCollectionItems();
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }

  /// Get collection items for a specific card
  Future<List<CollectionItemEntity>> getCollectionItemsByCardId(
    int cardId,
  ) async {
    try {
      return await _repository.getCollectionItemsByCardId(cardId);
    } catch (e) {
      // Don't emit error state for this read-only operation
      return [];
    }
  }

  List<CollectionItemWithCard> applySort(
    List<CollectionItemWithCard> collectionWithCards,
    SortOption option,
  ) {
    final sorted = List<CollectionItemWithCard>.from(collectionWithCards);
    sortCollectionItems(sorted, option);
    print('sorted: $sorted');
    return sorted;
  }
}
