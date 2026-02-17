import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_item.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/collection_repository.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_state.dart';
import 'package:bulk_box/src/features/sorting/domain/comparators/ygo_card_sorters.dart';
import 'package:bulk_box/src/features/sorting/domain/entities/sort_options.dart';

class CollectionCubit extends Cubit<CollectionState> {
  final CollectionRepository _repository;
  CollectionCubit(this._repository) : super(const CollectionState.initial());

  /// All collection entries loaded from the repository.
  List<CollectionEntry> _allEntries = [];

  /// Load collection items, optionally filtered by [boxId] or [unboxedOnly]. [boxName] is for display.
  Future<void> loadCollectionItems({
    int? boxId,
    bool unboxedOnly = false,
    String? boxName,
  }) async {
    emit(const CollectionState.loading());

    try {
      final entries = await _repository.getCollectionWithCards(
        boxId: boxId,
        unboxedOnly: unboxedOnly,
      );

      _allEntries = entries;

      emit(CollectionState.loaded(
        collectionEntries: entries,
        selectedBoxId: boxId,
        selectedBoxName: boxName,
      ));
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }

  /// Add a collection item
  Future<void> addCollectionItem(CollectionItemEntity item) async {
    try {
      await _repository.addCollectionItem(item);
      await _reloadWithCurrentFilter();
    } catch (e) {
      emit(CollectionState.error(e.toString()));
      rethrow;
    }
  }

  /// All slots for one card+set+rarity.
  Future<List<CollectionItemEntity>> getSlotsForCard(
    int cardId,
    String setCode,
    String setRarity,
  ) async {
    try {
      return await _repository.getSlotsForCard(cardId, setCode, setRarity);
    } catch (e) {
      return [];
    }
  }

  /// Update quantity for one slot; delete slot if quantity <= 0.
  Future<void> updateSlotQuantity(
    int cardId,
    String setCode,
    String setRarity,
    int? boxId,
    int quantity,
  ) async {
    try {
      await _repository.updateSlotQuantity(
        cardId,
        setCode,
        setRarity,
        boxId,
        quantity,
      );
      await _reloadWithCurrentFilter();
    } catch (e) {
      emit(CollectionState.error(e.toString()));
      rethrow;
    }
  }

  /// Delete one slot.
  Future<void> deleteSlot(
    int cardId,
    String setCode,
    String setRarity,
    int? boxId,
  ) async {
    try {
      await _repository.deleteSlot(cardId, setCode, setRarity, boxId);
      await _reloadWithCurrentFilter();
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }

  /// Move [amount] from one slot to another.
  Future<void> moveBetweenSlots(
    int cardId,
    String setCode,
    String setRarity,
    int? fromBoxId,
    int? toBoxId,
    int amount,
  ) async {
    try {
      await _repository.moveBetweenSlots(
        cardId,
        setCode,
        setRarity,
        fromBoxId,
        toBoxId,
        amount,
      );
      await _reloadWithCurrentFilter();
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }

  /// Move multiple entries to [toBoxId] in a single transaction.
  Future<void> batchMoveBetweenSlots({
    required List<({int cardId, String setCode, String setRarity, int quantity})> items,
    required int? fromBoxId,
    required int? toBoxId,
  }) async {
    try {
      await _repository.batchMoveBetweenSlots(
        items: items,
        fromBoxId: fromBoxId,
        toBoxId: toBoxId,
      );
      await _reloadWithCurrentFilter();
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }

  /// Delete multiple slots in a single transaction.
  Future<void> batchDeleteSlots(
    List<({int cardId, String setCode, String setRarity, int? boxId})> items,
  ) async {
    try {
      await _repository.batchDeleteSlots(items);
      await _reloadWithCurrentFilter();
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }

  Future<void> _reloadWithCurrentFilter() async {
    await state.maybeWhen(
      loaded: (_, __, ___, boxId, boxName) => loadCollectionItems(
        boxId: boxId,
        unboxedOnly: boxId == null && boxName == 'Unboxed',
        boxName: boxName,
      ),
      orElse: () => loadCollectionItems(),
    );
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

  List<CollectionEntry> applySort(
    List<CollectionEntry> collectionEntries,
    SortOption option,
  ) {
    final sorted = List<CollectionEntry>.from(collectionEntries);
    sortCollectionItems(sorted, option);
    return sorted;
  }

  /// Toggle search bar visibility.
  void toggleSearchBar() {
    state.maybeWhen(
      loaded: (entries, visible, query, boxId, boxName) {
        emit(CollectionState.loaded(
          collectionEntries: entries,
          searchBarVisible: !visible,
          searchQuery: query,
          selectedBoxId: boxId,
          selectedBoxName: boxName,
        ));
      },
      orElse: () {},
    );
  }

  /// Search for a collection entry by name or set code.
  void search(String query) {
    state.maybeWhen(
      loaded: (_, searchBarVisible, __, boxId, boxName) {
        final lower = query.toLowerCase();

        final filtered = _allEntries.where((entry) {
          final name = entry.card.name.toLowerCase();
          final set = entry.setCode.toLowerCase();

          return name.contains(lower) || set.contains(lower);
        }).toList();

        emit(CollectionState.loaded(
          collectionEntries: filtered,
          searchBarVisible: searchBarVisible,
          searchQuery: query,
          selectedBoxId: boxId,
          selectedBoxName: boxName,
        ));
      },
      orElse: () {},
    );
  }
}
