import 'package:bulk_box/src/features/collection/data/datasources/collection_local_datasource.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_item.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/collection_repository.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  final CollectionLocalDatasource _localDatasource;

  CollectionRepositoryImpl(this._localDatasource);

  @override
  Future<List<CollectionEntry>> getCollectionWithCards({
    int? boxId,
    bool unboxedOnly = false,
  }) async {
    return await _localDatasource.getCollectionWithCards(
      boxId: boxId,
      unboxedOnly: unboxedOnly,
    );
  }

  @override
  Future<List<CollectionEntry>> getFirstEntriesInBox(int boxId,
      {int limit = 3}) async {
    final all = await _localDatasource.getCollectionWithCards(boxId: boxId);
    return all.take(limit).toList();
  }

  @override
  Future<List<CollectionItemEntity>> getAllCollectionItems() async {
    return await _localDatasource.getAllCollectionItems();
  }

  @override
  Future<List<CollectionItemEntity>> getCollectionItemsByCardId(
    int cardId,
  ) async {
    return await _localDatasource.getCollectionItemsByCardId(cardId);
  }

  @override
  Future<List<CollectionItemEntity>> getSlotsForCard(
    int cardId,
    String setCode,
    String setRarity,
  ) async {
    return await _localDatasource.getSlotsForCard(cardId, setCode, setRarity);
  }

  @override
  Future<void> addCollectionItem(CollectionItemEntity item) async {
    await _localDatasource.insertOrUpdateCollectionItem(item);
  }

  @override
  Future<void> updateSlotQuantity(
    int cardId,
    String setCode,
    String setRarity,
    int? boxId,
    int quantity,
  ) async {
    await _localDatasource.updateSlotQuantity(
      cardId,
      setCode,
      setRarity,
      boxId,
      quantity,
    );
  }

  @override
  Future<void> deleteSlot(
    int cardId,
    String setCode,
    String setRarity,
    int? boxId,
  ) async {
    await _localDatasource.deleteSlot(cardId, setCode, setRarity, boxId);
  }

  @override
  Future<void> moveBetweenSlots(
    int cardId,
    String setCode,
    String setRarity,
    int? fromBoxId,
    int? toBoxId,
    int amount,
  ) async {
    await _localDatasource.moveBetweenSlots(
      cardId,
      setCode,
      setRarity,
      fromBoxId,
      toBoxId,
      amount,
    );
  }
}
