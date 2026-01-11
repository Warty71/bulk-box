// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CollectionItemsTable extends CollectionItems
    with TableInfo<$CollectionItemsTable, CollectionItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
      'card_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cardNameMeta =
      const VerificationMeta('cardName');
  @override
  late final GeneratedColumn<String> cardName = GeneratedColumn<String>(
      'card_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _setCodeMeta =
      const VerificationMeta('setCode');
  @override
  late final GeneratedColumn<String> setCode = GeneratedColumn<String>(
      'set_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _setRarityMeta =
      const VerificationMeta('setRarity');
  @override
  late final GeneratedColumn<String> setRarity = GeneratedColumn<String>(
      'set_rarity', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _conditionMeta =
      const VerificationMeta('condition');
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
      'condition', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateAddedMeta =
      const VerificationMeta('dateAdded');
  @override
  late final GeneratedColumn<DateTime> dateAdded = GeneratedColumn<DateTime>(
      'date_added', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [cardId, cardName, setCode, setRarity, quantity, condition, dateAdded];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collection_items';
  @override
  VerificationContext validateIntegrity(Insertable<CollectionItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('card_name')) {
      context.handle(_cardNameMeta,
          cardName.isAcceptableOrUnknown(data['card_name']!, _cardNameMeta));
    } else if (isInserting) {
      context.missing(_cardNameMeta);
    }
    if (data.containsKey('set_code')) {
      context.handle(_setCodeMeta,
          setCode.isAcceptableOrUnknown(data['set_code']!, _setCodeMeta));
    } else if (isInserting) {
      context.missing(_setCodeMeta);
    }
    if (data.containsKey('set_rarity')) {
      context.handle(_setRarityMeta,
          setRarity.isAcceptableOrUnknown(data['set_rarity']!, _setRarityMeta));
    } else if (isInserting) {
      context.missing(_setRarityMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('condition')) {
      context.handle(_conditionMeta,
          condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta));
    }
    if (data.containsKey('date_added')) {
      context.handle(_dateAddedMeta,
          dateAdded.isAcceptableOrUnknown(data['date_added']!, _dateAddedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cardId, setCode, setRarity};
  @override
  CollectionItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionItem(
      cardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}card_id'])!,
      cardName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_name'])!,
      setCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}set_code'])!,
      setRarity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}set_rarity'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      condition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}condition']),
      dateAdded: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_added'])!,
    );
  }

  @override
  $CollectionItemsTable createAlias(String alias) {
    return $CollectionItemsTable(attachedDatabase, alias);
  }
}

class CollectionItem extends DataClass implements Insertable<CollectionItem> {
  final int cardId;
  final String cardName;
  final String setCode;
  final String setRarity;
  final int quantity;
  final String? condition;
  final DateTime dateAdded;
  const CollectionItem(
      {required this.cardId,
      required this.cardName,
      required this.setCode,
      required this.setRarity,
      required this.quantity,
      this.condition,
      required this.dateAdded});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['card_id'] = Variable<int>(cardId);
    map['card_name'] = Variable<String>(cardName);
    map['set_code'] = Variable<String>(setCode);
    map['set_rarity'] = Variable<String>(setRarity);
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || condition != null) {
      map['condition'] = Variable<String>(condition);
    }
    map['date_added'] = Variable<DateTime>(dateAdded);
    return map;
  }

  CollectionItemsCompanion toCompanion(bool nullToAbsent) {
    return CollectionItemsCompanion(
      cardId: Value(cardId),
      cardName: Value(cardName),
      setCode: Value(setCode),
      setRarity: Value(setRarity),
      quantity: Value(quantity),
      condition: condition == null && nullToAbsent
          ? const Value.absent()
          : Value(condition),
      dateAdded: Value(dateAdded),
    );
  }

  factory CollectionItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionItem(
      cardId: serializer.fromJson<int>(json['cardId']),
      cardName: serializer.fromJson<String>(json['cardName']),
      setCode: serializer.fromJson<String>(json['setCode']),
      setRarity: serializer.fromJson<String>(json['setRarity']),
      quantity: serializer.fromJson<int>(json['quantity']),
      condition: serializer.fromJson<String?>(json['condition']),
      dateAdded: serializer.fromJson<DateTime>(json['dateAdded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cardId': serializer.toJson<int>(cardId),
      'cardName': serializer.toJson<String>(cardName),
      'setCode': serializer.toJson<String>(setCode),
      'setRarity': serializer.toJson<String>(setRarity),
      'quantity': serializer.toJson<int>(quantity),
      'condition': serializer.toJson<String?>(condition),
      'dateAdded': serializer.toJson<DateTime>(dateAdded),
    };
  }

  CollectionItem copyWith(
          {int? cardId,
          String? cardName,
          String? setCode,
          String? setRarity,
          int? quantity,
          Value<String?> condition = const Value.absent(),
          DateTime? dateAdded}) =>
      CollectionItem(
        cardId: cardId ?? this.cardId,
        cardName: cardName ?? this.cardName,
        setCode: setCode ?? this.setCode,
        setRarity: setRarity ?? this.setRarity,
        quantity: quantity ?? this.quantity,
        condition: condition.present ? condition.value : this.condition,
        dateAdded: dateAdded ?? this.dateAdded,
      );
  CollectionItem copyWithCompanion(CollectionItemsCompanion data) {
    return CollectionItem(
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      cardName: data.cardName.present ? data.cardName.value : this.cardName,
      setCode: data.setCode.present ? data.setCode.value : this.setCode,
      setRarity: data.setRarity.present ? data.setRarity.value : this.setRarity,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      condition: data.condition.present ? data.condition.value : this.condition,
      dateAdded: data.dateAdded.present ? data.dateAdded.value : this.dateAdded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionItem(')
          ..write('cardId: $cardId, ')
          ..write('cardName: $cardName, ')
          ..write('setCode: $setCode, ')
          ..write('setRarity: $setRarity, ')
          ..write('quantity: $quantity, ')
          ..write('condition: $condition, ')
          ..write('dateAdded: $dateAdded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      cardId, cardName, setCode, setRarity, quantity, condition, dateAdded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionItem &&
          other.cardId == this.cardId &&
          other.cardName == this.cardName &&
          other.setCode == this.setCode &&
          other.setRarity == this.setRarity &&
          other.quantity == this.quantity &&
          other.condition == this.condition &&
          other.dateAdded == this.dateAdded);
}

class CollectionItemsCompanion extends UpdateCompanion<CollectionItem> {
  final Value<int> cardId;
  final Value<String> cardName;
  final Value<String> setCode;
  final Value<String> setRarity;
  final Value<int> quantity;
  final Value<String?> condition;
  final Value<DateTime> dateAdded;
  final Value<int> rowid;
  const CollectionItemsCompanion({
    this.cardId = const Value.absent(),
    this.cardName = const Value.absent(),
    this.setCode = const Value.absent(),
    this.setRarity = const Value.absent(),
    this.quantity = const Value.absent(),
    this.condition = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CollectionItemsCompanion.insert({
    required int cardId,
    required String cardName,
    required String setCode,
    required String setRarity,
    this.quantity = const Value.absent(),
    this.condition = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : cardId = Value(cardId),
        cardName = Value(cardName),
        setCode = Value(setCode),
        setRarity = Value(setRarity);
  static Insertable<CollectionItem> custom({
    Expression<int>? cardId,
    Expression<String>? cardName,
    Expression<String>? setCode,
    Expression<String>? setRarity,
    Expression<int>? quantity,
    Expression<String>? condition,
    Expression<DateTime>? dateAdded,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cardId != null) 'card_id': cardId,
      if (cardName != null) 'card_name': cardName,
      if (setCode != null) 'set_code': setCode,
      if (setRarity != null) 'set_rarity': setRarity,
      if (quantity != null) 'quantity': quantity,
      if (condition != null) 'condition': condition,
      if (dateAdded != null) 'date_added': dateAdded,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CollectionItemsCompanion copyWith(
      {Value<int>? cardId,
      Value<String>? cardName,
      Value<String>? setCode,
      Value<String>? setRarity,
      Value<int>? quantity,
      Value<String?>? condition,
      Value<DateTime>? dateAdded,
      Value<int>? rowid}) {
    return CollectionItemsCompanion(
      cardId: cardId ?? this.cardId,
      cardName: cardName ?? this.cardName,
      setCode: setCode ?? this.setCode,
      setRarity: setRarity ?? this.setRarity,
      quantity: quantity ?? this.quantity,
      condition: condition ?? this.condition,
      dateAdded: dateAdded ?? this.dateAdded,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (cardName.present) {
      map['card_name'] = Variable<String>(cardName.value);
    }
    if (setCode.present) {
      map['set_code'] = Variable<String>(setCode.value);
    }
    if (setRarity.present) {
      map['set_rarity'] = Variable<String>(setRarity.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (dateAdded.present) {
      map['date_added'] = Variable<DateTime>(dateAdded.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionItemsCompanion(')
          ..write('cardId: $cardId, ')
          ..write('cardName: $cardName, ')
          ..write('setCode: $setCode, ')
          ..write('setRarity: $setRarity, ')
          ..write('quantity: $quantity, ')
          ..write('condition: $condition, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CollectionItemsTable collectionItems =
      $CollectionItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [collectionItems];
}

typedef $$CollectionItemsTableCreateCompanionBuilder = CollectionItemsCompanion
    Function({
  required int cardId,
  required String cardName,
  required String setCode,
  required String setRarity,
  Value<int> quantity,
  Value<String?> condition,
  Value<DateTime> dateAdded,
  Value<int> rowid,
});
typedef $$CollectionItemsTableUpdateCompanionBuilder = CollectionItemsCompanion
    Function({
  Value<int> cardId,
  Value<String> cardName,
  Value<String> setCode,
  Value<String> setRarity,
  Value<int> quantity,
  Value<String?> condition,
  Value<DateTime> dateAdded,
  Value<int> rowid,
});

class $$CollectionItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionItemsTable> {
  $$CollectionItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get cardId => $composableBuilder(
      column: $table.cardId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardName => $composableBuilder(
      column: $table.cardName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get setCode => $composableBuilder(
      column: $table.setCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get setRarity => $composableBuilder(
      column: $table.setRarity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get condition => $composableBuilder(
      column: $table.condition, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateAdded => $composableBuilder(
      column: $table.dateAdded, builder: (column) => ColumnFilters(column));
}

class $$CollectionItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionItemsTable> {
  $$CollectionItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get cardId => $composableBuilder(
      column: $table.cardId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardName => $composableBuilder(
      column: $table.cardName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get setCode => $composableBuilder(
      column: $table.setCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get setRarity => $composableBuilder(
      column: $table.setRarity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get condition => $composableBuilder(
      column: $table.condition, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateAdded => $composableBuilder(
      column: $table.dateAdded, builder: (column) => ColumnOrderings(column));
}

class $$CollectionItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionItemsTable> {
  $$CollectionItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get cardId =>
      $composableBuilder(column: $table.cardId, builder: (column) => column);

  GeneratedColumn<String> get cardName =>
      $composableBuilder(column: $table.cardName, builder: (column) => column);

  GeneratedColumn<String> get setCode =>
      $composableBuilder(column: $table.setCode, builder: (column) => column);

  GeneratedColumn<String> get setRarity =>
      $composableBuilder(column: $table.setRarity, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<DateTime> get dateAdded =>
      $composableBuilder(column: $table.dateAdded, builder: (column) => column);
}

class $$CollectionItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CollectionItemsTable,
    CollectionItem,
    $$CollectionItemsTableFilterComposer,
    $$CollectionItemsTableOrderingComposer,
    $$CollectionItemsTableAnnotationComposer,
    $$CollectionItemsTableCreateCompanionBuilder,
    $$CollectionItemsTableUpdateCompanionBuilder,
    (
      CollectionItem,
      BaseReferences<_$AppDatabase, $CollectionItemsTable, CollectionItem>
    ),
    CollectionItem,
    PrefetchHooks Function()> {
  $$CollectionItemsTableTableManager(
      _$AppDatabase db, $CollectionItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectionItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CollectionItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> cardId = const Value.absent(),
            Value<String> cardName = const Value.absent(),
            Value<String> setCode = const Value.absent(),
            Value<String> setRarity = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<String?> condition = const Value.absent(),
            Value<DateTime> dateAdded = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CollectionItemsCompanion(
            cardId: cardId,
            cardName: cardName,
            setCode: setCode,
            setRarity: setRarity,
            quantity: quantity,
            condition: condition,
            dateAdded: dateAdded,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int cardId,
            required String cardName,
            required String setCode,
            required String setRarity,
            Value<int> quantity = const Value.absent(),
            Value<String?> condition = const Value.absent(),
            Value<DateTime> dateAdded = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CollectionItemsCompanion.insert(
            cardId: cardId,
            cardName: cardName,
            setCode: setCode,
            setRarity: setRarity,
            quantity: quantity,
            condition: condition,
            dateAdded: dateAdded,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CollectionItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CollectionItemsTable,
    CollectionItem,
    $$CollectionItemsTableFilterComposer,
    $$CollectionItemsTableOrderingComposer,
    $$CollectionItemsTableAnnotationComposer,
    $$CollectionItemsTableCreateCompanionBuilder,
    $$CollectionItemsTableUpdateCompanionBuilder,
    (
      CollectionItem,
      BaseReferences<_$AppDatabase, $CollectionItemsTable, CollectionItem>
    ),
    CollectionItem,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CollectionItemsTableTableManager get collectionItems =>
      $$CollectionItemsTableTableManager(_db, _db.collectionItems);
}
