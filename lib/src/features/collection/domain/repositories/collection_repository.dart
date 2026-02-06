import 'package:bulk_box/src/features/collection/domain/entities/collection_item.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';

abstract class CollectionRepository {
  /// [boxId] null = all slots; [unboxedOnly] true = only unboxed slots.
  Future<List<CollectionEntry>> getCollectionWithCards({
    int? boxId,
    bool unboxedOnly = false,
  });

  /// First [limit] entries in the box (for preview thumbnails). Default 3.
  Future<List<CollectionEntry>> getFirstEntriesInBox(int boxId, {int limit = 3});

  /// Total number of cards in the collection (sum of all slot quantities).
  Future<int> getTotalCardCount();

  Future<List<CollectionItemEntity>> getAllCollectionItems();

  /// All slots for a card (any set/rarity).
  Future<List<CollectionItemEntity>> getCollectionItemsByCardId(int cardId);

  /// All slots for one card+set+rarity (where each copy is).
  Future<List<CollectionItemEntity>> getSlotsForCard(
    int cardId,
    String setCode,
    String setRarity,
  );

  /// Add or increment slot (card+set+rarity+box).
  Future<void> addCollectionItem(CollectionItemEntity item);

  /// Update quantity for one slot; delete slot if quantity <= 0.
  Future<void> updateSlotQuantity(
    int cardId,
    String setCode,
    String setRarity,
    int? boxId,
    int quantity,
  );

  /// Delete one slot.
  Future<void> deleteSlot(
    int cardId,
    String setCode,
    String setRarity,
    int? boxId,
  );

  /// Move [amount] from one slot to another.
  Future<void> moveBetweenSlots(
    int cardId,
    String setCode,
    String setRarity,
    int? fromBoxId,
    int? toBoxId,
    int amount,
  );
}
