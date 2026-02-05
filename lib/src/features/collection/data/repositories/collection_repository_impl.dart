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
  Future<CollectionItemEntity?> getCollectionItem(
    int cardId,
    String setCode,
    String setRarity,
  ) async {
    return await _localDatasource.getCollectionItem(cardId, setCode, setRarity);
  }

  @override
  Future<void> addCollectionItem(CollectionItemEntity item) async {
    await _localDatasource.insertOrUpdateCollectionItem(item);
  }

  @override
  Future<void> updateQuantity(
    int cardId,
    String setCode,
    String setRarity,
    int quantity,
  ) async {
    await _localDatasource.updateQuantity(cardId, setCode, setRarity, quantity);
  }

  @override
  Future<void> removeCollectionItem(
    int cardId,
    String setCode,
    String setRarity,
  ) async {
    await _localDatasource.decreaseQuantity(cardId, setCode, setRarity);
  }

  @override
  Future<void> deleteCollectionItem(
    int cardId,
    String setCode,
    String setRarity,
  ) async {
    await _localDatasource.deleteCollectionItem(cardId, setCode, setRarity);
  }

  @override
  Future<void> assignItemToBox(
    int cardId,
    String setCode,
    String setRarity,
    int? boxId,
  ) async {
    await _localDatasource.assignItemToBox(
      cardId,
      setCode,
      setRarity,
      boxId,
    );
  }
}
