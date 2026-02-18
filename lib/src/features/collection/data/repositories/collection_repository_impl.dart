import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/features/collection/data/datasources/collection_local_datasource.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_item.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/collection_repository.dart';
import 'package:bulk_box/src/features/ygo_cards/data/mappers/card_model_mapper.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  final CollectionLocalDatasource _localDatasource;
  final CardDao _cardDao;

  CollectionRepositoryImpl(this._localDatasource, this._cardDao);

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
  Future<int> getTotalCardCount() async {
    return await _localDatasource.getTotalCardCount();
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

  @override
  Future<void> batchMoveBetweenSlots({
    required List<({int cardId, String setCode, String setRarity, int quantity})> items,
    required int? fromBoxId,
    required int? toBoxId,
  }) async {
    await _localDatasource.batchMoveBetweenSlots(
      items: items,
      fromBoxId: fromBoxId,
      toBoxId: toBoxId,
    );
  }

  @override
  Future<void> batchDeleteSlots(
    List<({int cardId, String setCode, String setRarity, int? boxId})> items,
  ) async {
    await _localDatasource.batchDeleteSlots(items);
  }

  @override
  Future<void> ensureCardExists(YgoCard card) async {
    await _cardDao.insertOrUpdateCards([CardModelMapper.toDriftCard(card)]);
  }

  @override
  Future<void> saveCardQuantities(
    YgoCard card,
    Map<String, int> quantities,
    List<({String setCode, String setRarity})> sets,
  ) async {
    await ensureCardExists(card);
    final now = DateTime.now();

    for (final set in sets) {
      final key = '${set.setCode}_${set.setRarity}';
      final newTotal = quantities[key] ?? 0;
      final slots = await _localDatasource.getSlotsForCard(
        card.id,
        set.setCode,
        set.setRarity,
      );
      final oldTotal = slots.fold<int>(0, (sum, s) => sum + s.quantity);
      final delta = newTotal - oldTotal;

      if (delta > 0) {
        for (var i = 0; i < delta; i++) {
          await _localDatasource.insertOrUpdateCollectionItem(
            CollectionItemEntity(
              cardId: card.id,
              setCode: set.setCode,
              setRarity: set.setRarity,
              quantity: 1,
              dateAdded: now,
              boxId: null,
            ),
          );
        }
      } else if (delta < 0) {
        final selectedSlot = slots.isEmpty
            ? null
            : (slots.where((s) => s.boxId == null).firstOrNull ?? slots.first);
        if (selectedSlot != null) {
          var remove = -delta;
          var q = selectedSlot.quantity;
          while (remove > 0 && q > 0) {
            q--;
            remove--;
            await _localDatasource.updateSlotQuantity(
              card.id,
              set.setCode,
              set.setRarity,
              selectedSlot.boxId,
              q,
            );
          }
        }
      }
    }
  }
}
