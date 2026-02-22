import 'package:drift/drift.dart';
import 'package:bulk_box/src/core/database/app_database.dart';
import 'package:bulk_box/src/core/database/box_dao.dart';
import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/features/backup/data/datasources/backup_datasource.dart';
import 'package:bulk_box/src/features/backup/domain/entities/backup_box_data.dart';
import 'package:bulk_box/src/features/backup/domain/entities/backup_card_data.dart';
import 'package:bulk_box/src/features/backup/domain/entities/backup_item_data.dart';
import 'package:bulk_box/src/features/backup/domain/entities/backup_manifest.dart';
import 'package:bulk_box/src/features/backup/domain/entities/import_result.dart';
import 'package:bulk_box/src/features/backup/domain/repositories/backup_repository.dart';
import 'package:bulk_box/src/features/collection/data/datasources/collection_local_datasource.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_item.dart';
import 'package:bulk_box/src/features/ygo_cards/data/mappers/card_model_mapper.dart';

class BackupRepositoryImpl implements BackupRepository {
  final CardDao _cardDao;
  final CollectionLocalDatasource _collectionDatasource;
  final BoxDao _boxDao;
  final AppDatabase _database;
  final BackupDatasource _backupDatasource;

  BackupRepositoryImpl({
    required CardDao cardDao,
    required CollectionLocalDatasource collectionDatasource,
    required BoxDao boxDao,
    required AppDatabase database,
    required BackupDatasource backupDatasource,
  })  : _cardDao = cardDao,
        _collectionDatasource = collectionDatasource,
        _boxDao = boxDao,
        _database = database,
        _backupDatasource = backupDatasource;

  @override
  Future<String> exportCollection() async {
    final boxes = await _boxDao.getAllBoxes();
    final allItems = await _collectionDatasource.getAllCollectionItems();
    final allCardIds = allItems.map((i) => i.cardId).toSet().toList();
    final driftCards = await _cardDao.getCardsByIds(allCardIds);

    final backupCards = driftCards
        .map((c) => BackupCardData.fromYgoCard(CardModelMapper.fromDriftCard(c)))
        .toList();

    final backupBoxes = boxes.map((box) {
      final boxItems = allItems
          .where((item) => item.boxId == box.id)
          .map((item) => _itemToBackup(item))
          .toList();
      return BackupBoxData(
        name: box.name,
        color: box.color,
        sortOrder: box.sortOrder,
        items: boxItems,
      );
    }).toList();

    final unboxedItems = allItems
        .where((item) => item.boxId == null)
        .map((item) => _itemToBackup(item))
        .toList();

    final manifest = BackupManifest(
      version: BackupManifest.currentVersion,
      schemaVersion: _database.schemaVersion,
      exportedAt: DateTime.now().toUtc(),
      cards: backupCards,
      boxes: backupBoxes,
      unboxedItems: unboxedItems,
    );

    return _backupDatasource.writeToFile(manifest);
  }

  @override
  Future<BackupManifest> parseBackupFile(String filePath) {
    return _backupDatasource.readFromFile(filePath);
  }

  @override
  Future<ImportResult> importCollection(
    BackupManifest manifest, {
    required bool merge,
  }) async {
    int boxesImported = 0;
    int itemsImported = 0;
    int cardsCached = 0;

    await _database.transaction(() async {
      // Clear existing data in replace mode (items first to satisfy FK constraint)
      if (!merge) {
        await _collectionDatasource.deleteAllItems();
        await _boxDao.deleteAll();
      }

      // Cache card data
      final driftCards = manifest.cards
          .map((c) => CardModelMapper.toDriftCard(c.toYgoCard()))
          .toList();
      await _cardDao.insertOrUpdateCards(driftCards);
      cardsCached = driftCards.length;

      // Insert boxes and their items
      for (final backupBox in manifest.boxes) {
        final existingBoxes = await _boxDao.getAllBoxes();
        final alreadyExists =
            existingBoxes.any((b) => b.name == backupBox.name);
        final boxId = await _resolveBoxId(backupBox, merge);
        if (!merge || !alreadyExists) boxesImported++;

        for (final item in backupBox.items) {
          await _collectionDatasource.insertOrUpdateCollectionItem(
            _backupItemToEntity(item, boxId: boxId),
          );
          itemsImported++;
        }
      }

      // Insert unboxed items
      for (final item in manifest.unboxedItems) {
        await _collectionDatasource.insertOrUpdateCollectionItem(
          _backupItemToEntity(item, boxId: null),
        );
        itemsImported++;
      }
    });

    return ImportResult(
      boxesImported: boxesImported,
      itemsImported: itemsImported,
      cardsCached: cardsCached,
    );
  }

  Future<int> _resolveBoxId(BackupBoxData backupBox, bool merge) async {
    if (merge) {
      final allBoxes = await _boxDao.getAllBoxes();
      final existing =
          allBoxes.where((b) => b.name == backupBox.name).firstOrNull;
      if (existing != null) return existing.id;
    }
    return _boxDao.insertBox(BoxesCompanion(
      name: Value(backupBox.name),
      color: Value(backupBox.color),
      sortOrder: Value(backupBox.sortOrder),
    ));
  }

  BackupItemData _itemToBackup(CollectionItemEntity item) => BackupItemData(
        cardId: item.cardId,
        setCode: item.setCode,
        setRarity: item.setRarity,
        quantity: item.quantity,
        condition: item.condition,
        dateAdded: item.dateAdded,
      );

  CollectionItemEntity _backupItemToEntity(
    BackupItemData item, {
    required int? boxId,
  }) =>
      CollectionItemEntity(
        cardId: item.cardId,
        setCode: item.setCode,
        setRarity: item.setRarity,
        quantity: item.quantity,
        condition: item.condition,
        dateAdded: item.dateAdded,
        boxId: boxId,
      );
}
