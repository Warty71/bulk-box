// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CardsTable extends Cards with TableInfo<$CardsTable, Card> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _raceMeta = const VerificationMeta('race');
  @override
  late final GeneratedColumn<String> race = GeneratedColumn<String>(
      'race', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _attributeMeta =
      const VerificationMeta('attribute');
  @override
  late final GeneratedColumn<String> attribute = GeneratedColumn<String>(
      'attribute', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _atkMeta = const VerificationMeta('atk');
  @override
  late final GeneratedColumn<int> atk = GeneratedColumn<int>(
      'atk', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _defMeta = const VerificationMeta('def');
  @override
  late final GeneratedColumn<int> def = GeneratedColumn<int>(
      'def', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cardSetsJsonMeta =
      const VerificationMeta('cardSetsJson');
  @override
  late final GeneratedColumn<String> cardSetsJson = GeneratedColumn<String>(
      'card_sets_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        type,
        description,
        race,
        attribute,
        level,
        atk,
        def,
        imageUrl,
        cardSetsJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cards';
  @override
  VerificationContext validateIntegrity(Insertable<Card> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('race')) {
      context.handle(
          _raceMeta, race.isAcceptableOrUnknown(data['race']!, _raceMeta));
    } else if (isInserting) {
      context.missing(_raceMeta);
    }
    if (data.containsKey('attribute')) {
      context.handle(_attributeMeta,
          attribute.isAcceptableOrUnknown(data['attribute']!, _attributeMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('atk')) {
      context.handle(
          _atkMeta, atk.isAcceptableOrUnknown(data['atk']!, _atkMeta));
    }
    if (data.containsKey('def')) {
      context.handle(
          _defMeta, def.isAcceptableOrUnknown(data['def']!, _defMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('card_sets_json')) {
      context.handle(
          _cardSetsJsonMeta,
          cardSetsJson.isAcceptableOrUnknown(
              data['card_sets_json']!, _cardSetsJsonMeta));
    } else if (isInserting) {
      context.missing(_cardSetsJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Card map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Card(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      race: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}race'])!,
      attribute: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}attribute']),
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level']),
      atk: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}atk']),
      def: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}def']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      cardSetsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_sets_json'])!,
    );
  }

  @override
  $CardsTable createAlias(String alias) {
    return $CardsTable(attachedDatabase, alias);
  }
}

class Card extends DataClass implements Insertable<Card> {
  final int id;
  final String name;
  final String type;
  final String description;
  final String race;
  final String? attribute;
  final int? level;
  final int? atk;
  final int? def;
  final String imageUrl;
  final String cardSetsJson;
  const Card(
      {required this.id,
      required this.name,
      required this.type,
      required this.description,
      required this.race,
      this.attribute,
      this.level,
      this.atk,
      this.def,
      required this.imageUrl,
      required this.cardSetsJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['description'] = Variable<String>(description);
    map['race'] = Variable<String>(race);
    if (!nullToAbsent || attribute != null) {
      map['attribute'] = Variable<String>(attribute);
    }
    if (!nullToAbsent || level != null) {
      map['level'] = Variable<int>(level);
    }
    if (!nullToAbsent || atk != null) {
      map['atk'] = Variable<int>(atk);
    }
    if (!nullToAbsent || def != null) {
      map['def'] = Variable<int>(def);
    }
    map['image_url'] = Variable<String>(imageUrl);
    map['card_sets_json'] = Variable<String>(cardSetsJson);
    return map;
  }

  CardsCompanion toCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      description: Value(description),
      race: Value(race),
      attribute: attribute == null && nullToAbsent
          ? const Value.absent()
          : Value(attribute),
      level:
          level == null && nullToAbsent ? const Value.absent() : Value(level),
      atk: atk == null && nullToAbsent ? const Value.absent() : Value(atk),
      def: def == null && nullToAbsent ? const Value.absent() : Value(def),
      imageUrl: Value(imageUrl),
      cardSetsJson: Value(cardSetsJson),
    );
  }

  factory Card.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Card(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      description: serializer.fromJson<String>(json['description']),
      race: serializer.fromJson<String>(json['race']),
      attribute: serializer.fromJson<String?>(json['attribute']),
      level: serializer.fromJson<int?>(json['level']),
      atk: serializer.fromJson<int?>(json['atk']),
      def: serializer.fromJson<int?>(json['def']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      cardSetsJson: serializer.fromJson<String>(json['cardSetsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'description': serializer.toJson<String>(description),
      'race': serializer.toJson<String>(race),
      'attribute': serializer.toJson<String?>(attribute),
      'level': serializer.toJson<int?>(level),
      'atk': serializer.toJson<int?>(atk),
      'def': serializer.toJson<int?>(def),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'cardSetsJson': serializer.toJson<String>(cardSetsJson),
    };
  }

  Card copyWith(
          {int? id,
          String? name,
          String? type,
          String? description,
          String? race,
          Value<String?> attribute = const Value.absent(),
          Value<int?> level = const Value.absent(),
          Value<int?> atk = const Value.absent(),
          Value<int?> def = const Value.absent(),
          String? imageUrl,
          String? cardSetsJson}) =>
      Card(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        description: description ?? this.description,
        race: race ?? this.race,
        attribute: attribute.present ? attribute.value : this.attribute,
        level: level.present ? level.value : this.level,
        atk: atk.present ? atk.value : this.atk,
        def: def.present ? def.value : this.def,
        imageUrl: imageUrl ?? this.imageUrl,
        cardSetsJson: cardSetsJson ?? this.cardSetsJson,
      );
  Card copyWithCompanion(CardsCompanion data) {
    return Card(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      description:
          data.description.present ? data.description.value : this.description,
      race: data.race.present ? data.race.value : this.race,
      attribute: data.attribute.present ? data.attribute.value : this.attribute,
      level: data.level.present ? data.level.value : this.level,
      atk: data.atk.present ? data.atk.value : this.atk,
      def: data.def.present ? data.def.value : this.def,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      cardSetsJson: data.cardSetsJson.present
          ? data.cardSetsJson.value
          : this.cardSetsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Card(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('race: $race, ')
          ..write('attribute: $attribute, ')
          ..write('level: $level, ')
          ..write('atk: $atk, ')
          ..write('def: $def, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('cardSetsJson: $cardSetsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, description, race, attribute,
      level, atk, def, imageUrl, cardSetsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Card &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.description == this.description &&
          other.race == this.race &&
          other.attribute == this.attribute &&
          other.level == this.level &&
          other.atk == this.atk &&
          other.def == this.def &&
          other.imageUrl == this.imageUrl &&
          other.cardSetsJson == this.cardSetsJson);
}

class CardsCompanion extends UpdateCompanion<Card> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> description;
  final Value<String> race;
  final Value<String?> attribute;
  final Value<int?> level;
  final Value<int?> atk;
  final Value<int?> def;
  final Value<String> imageUrl;
  final Value<String> cardSetsJson;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.race = const Value.absent(),
    this.attribute = const Value.absent(),
    this.level = const Value.absent(),
    this.atk = const Value.absent(),
    this.def = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.cardSetsJson = const Value.absent(),
  });
  CardsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String type,
    required String description,
    required String race,
    this.attribute = const Value.absent(),
    this.level = const Value.absent(),
    this.atk = const Value.absent(),
    this.def = const Value.absent(),
    required String imageUrl,
    required String cardSetsJson,
  })  : name = Value(name),
        type = Value(type),
        description = Value(description),
        race = Value(race),
        imageUrl = Value(imageUrl),
        cardSetsJson = Value(cardSetsJson);
  static Insertable<Card> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? description,
    Expression<String>? race,
    Expression<String>? attribute,
    Expression<int>? level,
    Expression<int>? atk,
    Expression<int>? def,
    Expression<String>? imageUrl,
    Expression<String>? cardSetsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
      if (race != null) 'race': race,
      if (attribute != null) 'attribute': attribute,
      if (level != null) 'level': level,
      if (atk != null) 'atk': atk,
      if (def != null) 'def': def,
      if (imageUrl != null) 'image_url': imageUrl,
      if (cardSetsJson != null) 'card_sets_json': cardSetsJson,
    });
  }

  CardsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? type,
      Value<String>? description,
      Value<String>? race,
      Value<String?>? attribute,
      Value<int?>? level,
      Value<int?>? atk,
      Value<int?>? def,
      Value<String>? imageUrl,
      Value<String>? cardSetsJson}) {
    return CardsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      race: race ?? this.race,
      attribute: attribute ?? this.attribute,
      level: level ?? this.level,
      atk: atk ?? this.atk,
      def: def ?? this.def,
      imageUrl: imageUrl ?? this.imageUrl,
      cardSetsJson: cardSetsJson ?? this.cardSetsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (race.present) {
      map['race'] = Variable<String>(race.value);
    }
    if (attribute.present) {
      map['attribute'] = Variable<String>(attribute.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (atk.present) {
      map['atk'] = Variable<int>(atk.value);
    }
    if (def.present) {
      map['def'] = Variable<int>(def.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (cardSetsJson.present) {
      map['card_sets_json'] = Variable<String>(cardSetsJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('race: $race, ')
          ..write('attribute: $attribute, ')
          ..write('level: $level, ')
          ..write('atk: $atk, ')
          ..write('def: $def, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('cardSetsJson: $cardSetsJson')
          ..write(')'))
        .toString();
  }
}

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
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cards (id)'));
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
      [cardId, setCode, setRarity, quantity, condition, dateAdded];
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
  final String setCode;
  final String setRarity;
  final int quantity;
  final String? condition;
  final DateTime dateAdded;
  const CollectionItem(
      {required this.cardId,
      required this.setCode,
      required this.setRarity,
      required this.quantity,
      this.condition,
      required this.dateAdded});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['card_id'] = Variable<int>(cardId);
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
      'setCode': serializer.toJson<String>(setCode),
      'setRarity': serializer.toJson<String>(setRarity),
      'quantity': serializer.toJson<int>(quantity),
      'condition': serializer.toJson<String?>(condition),
      'dateAdded': serializer.toJson<DateTime>(dateAdded),
    };
  }

  CollectionItem copyWith(
          {int? cardId,
          String? setCode,
          String? setRarity,
          int? quantity,
          Value<String?> condition = const Value.absent(),
          DateTime? dateAdded}) =>
      CollectionItem(
        cardId: cardId ?? this.cardId,
        setCode: setCode ?? this.setCode,
        setRarity: setRarity ?? this.setRarity,
        quantity: quantity ?? this.quantity,
        condition: condition.present ? condition.value : this.condition,
        dateAdded: dateAdded ?? this.dateAdded,
      );
  CollectionItem copyWithCompanion(CollectionItemsCompanion data) {
    return CollectionItem(
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
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
          ..write('setCode: $setCode, ')
          ..write('setRarity: $setRarity, ')
          ..write('quantity: $quantity, ')
          ..write('condition: $condition, ')
          ..write('dateAdded: $dateAdded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(cardId, setCode, setRarity, quantity, condition, dateAdded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionItem &&
          other.cardId == this.cardId &&
          other.setCode == this.setCode &&
          other.setRarity == this.setRarity &&
          other.quantity == this.quantity &&
          other.condition == this.condition &&
          other.dateAdded == this.dateAdded);
}

class CollectionItemsCompanion extends UpdateCompanion<CollectionItem> {
  final Value<int> cardId;
  final Value<String> setCode;
  final Value<String> setRarity;
  final Value<int> quantity;
  final Value<String?> condition;
  final Value<DateTime> dateAdded;
  final Value<int> rowid;
  const CollectionItemsCompanion({
    this.cardId = const Value.absent(),
    this.setCode = const Value.absent(),
    this.setRarity = const Value.absent(),
    this.quantity = const Value.absent(),
    this.condition = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CollectionItemsCompanion.insert({
    required int cardId,
    required String setCode,
    required String setRarity,
    this.quantity = const Value.absent(),
    this.condition = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : cardId = Value(cardId),
        setCode = Value(setCode),
        setRarity = Value(setRarity);
  static Insertable<CollectionItem> custom({
    Expression<int>? cardId,
    Expression<String>? setCode,
    Expression<String>? setRarity,
    Expression<int>? quantity,
    Expression<String>? condition,
    Expression<DateTime>? dateAdded,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cardId != null) 'card_id': cardId,
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
      Value<String>? setCode,
      Value<String>? setRarity,
      Value<int>? quantity,
      Value<String?>? condition,
      Value<DateTime>? dateAdded,
      Value<int>? rowid}) {
    return CollectionItemsCompanion(
      cardId: cardId ?? this.cardId,
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
  late final $CardsTable cards = $CardsTable(this);
  late final $CollectionItemsTable collectionItems =
      $CollectionItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cards, collectionItems];
}

typedef $$CardsTableCreateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  required String name,
  required String type,
  required String description,
  required String race,
  Value<String?> attribute,
  Value<int?> level,
  Value<int?> atk,
  Value<int?> def,
  required String imageUrl,
  required String cardSetsJson,
});
typedef $$CardsTableUpdateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> type,
  Value<String> description,
  Value<String> race,
  Value<String?> attribute,
  Value<int?> level,
  Value<int?> atk,
  Value<int?> def,
  Value<String> imageUrl,
  Value<String> cardSetsJson,
});

final class $$CardsTableReferences
    extends BaseReferences<_$AppDatabase, $CardsTable, Card> {
  $$CardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CollectionItemsTable, List<CollectionItem>>
      _collectionItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.collectionItems,
              aliasName:
                  $_aliasNameGenerator(db.cards.id, db.collectionItems.cardId));

  $$CollectionItemsTableProcessedTableManager get collectionItemsRefs {
    final manager =
        $$CollectionItemsTableTableManager($_db, $_db.collectionItems)
            .filter((f) => f.cardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_collectionItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CardsTableFilterComposer extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get race => $composableBuilder(
      column: $table.race, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get attribute => $composableBuilder(
      column: $table.attribute, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get atk => $composableBuilder(
      column: $table.atk, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get def => $composableBuilder(
      column: $table.def, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardSetsJson => $composableBuilder(
      column: $table.cardSetsJson, builder: (column) => ColumnFilters(column));

  Expression<bool> collectionItemsRefs(
      Expression<bool> Function($$CollectionItemsTableFilterComposer f) f) {
    final $$CollectionItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.collectionItems,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectionItemsTableFilterComposer(
              $db: $db,
              $table: $db.collectionItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CardsTableOrderingComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get race => $composableBuilder(
      column: $table.race, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get attribute => $composableBuilder(
      column: $table.attribute, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get atk => $composableBuilder(
      column: $table.atk, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get def => $composableBuilder(
      column: $table.def, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardSetsJson => $composableBuilder(
      column: $table.cardSetsJson,
      builder: (column) => ColumnOrderings(column));
}

class $$CardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get race =>
      $composableBuilder(column: $table.race, builder: (column) => column);

  GeneratedColumn<String> get attribute =>
      $composableBuilder(column: $table.attribute, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get atk =>
      $composableBuilder(column: $table.atk, builder: (column) => column);

  GeneratedColumn<int> get def =>
      $composableBuilder(column: $table.def, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get cardSetsJson => $composableBuilder(
      column: $table.cardSetsJson, builder: (column) => column);

  Expression<T> collectionItemsRefs<T extends Object>(
      Expression<T> Function($$CollectionItemsTableAnnotationComposer a) f) {
    final $$CollectionItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.collectionItems,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectionItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.collectionItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CardsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardsTable,
    Card,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (Card, $$CardsTableReferences),
    Card,
    PrefetchHooks Function({bool collectionItemsRefs})> {
  $$CardsTableTableManager(_$AppDatabase db, $CardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> race = const Value.absent(),
            Value<String?> attribute = const Value.absent(),
            Value<int?> level = const Value.absent(),
            Value<int?> atk = const Value.absent(),
            Value<int?> def = const Value.absent(),
            Value<String> imageUrl = const Value.absent(),
            Value<String> cardSetsJson = const Value.absent(),
          }) =>
              CardsCompanion(
            id: id,
            name: name,
            type: type,
            description: description,
            race: race,
            attribute: attribute,
            level: level,
            atk: atk,
            def: def,
            imageUrl: imageUrl,
            cardSetsJson: cardSetsJson,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String type,
            required String description,
            required String race,
            Value<String?> attribute = const Value.absent(),
            Value<int?> level = const Value.absent(),
            Value<int?> atk = const Value.absent(),
            Value<int?> def = const Value.absent(),
            required String imageUrl,
            required String cardSetsJson,
          }) =>
              CardsCompanion.insert(
            id: id,
            name: name,
            type: type,
            description: description,
            race: race,
            attribute: attribute,
            level: level,
            atk: atk,
            def: def,
            imageUrl: imageUrl,
            cardSetsJson: cardSetsJson,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CardsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({collectionItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (collectionItemsRefs) db.collectionItems
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (collectionItemsRefs)
                    await $_getPrefetchedData<Card, $CardsTable,
                            CollectionItem>(
                        currentTable: table,
                        referencedTable: $$CardsTableReferences
                            ._collectionItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CardsTableReferences(db, table, p0)
                                .collectionItemsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.cardId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CardsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CardsTable,
    Card,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (Card, $$CardsTableReferences),
    Card,
    PrefetchHooks Function({bool collectionItemsRefs})>;
typedef $$CollectionItemsTableCreateCompanionBuilder = CollectionItemsCompanion
    Function({
  required int cardId,
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
  Value<String> setCode,
  Value<String> setRarity,
  Value<int> quantity,
  Value<String?> condition,
  Value<DateTime> dateAdded,
  Value<int> rowid,
});

final class $$CollectionItemsTableReferences extends BaseReferences<
    _$AppDatabase, $CollectionItemsTable, CollectionItem> {
  $$CollectionItemsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CardsTable _cardIdTable(_$AppDatabase db) => db.cards.createAlias(
      $_aliasNameGenerator(db.collectionItems.cardId, db.cards.id));

  $$CardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<int>('card_id')!;

    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CollectionItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionItemsTable> {
  $$CollectionItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
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

  $$CardsTableFilterComposer get cardId {
    final $$CardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableFilterComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
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

  $$CardsTableOrderingComposer get cardId {
    final $$CardsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableOrderingComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
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

  $$CardsTableAnnotationComposer get cardId {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableAnnotationComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
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
    (CollectionItem, $$CollectionItemsTableReferences),
    CollectionItem,
    PrefetchHooks Function({bool cardId})> {
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
            Value<String> setCode = const Value.absent(),
            Value<String> setRarity = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<String?> condition = const Value.absent(),
            Value<DateTime> dateAdded = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CollectionItemsCompanion(
            cardId: cardId,
            setCode: setCode,
            setRarity: setRarity,
            quantity: quantity,
            condition: condition,
            dateAdded: dateAdded,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int cardId,
            required String setCode,
            required String setRarity,
            Value<int> quantity = const Value.absent(),
            Value<String?> condition = const Value.absent(),
            Value<DateTime> dateAdded = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CollectionItemsCompanion.insert(
            cardId: cardId,
            setCode: setCode,
            setRarity: setRarity,
            quantity: quantity,
            condition: condition,
            dateAdded: dateAdded,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CollectionItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (cardId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cardId,
                    referencedTable:
                        $$CollectionItemsTableReferences._cardIdTable(db),
                    referencedColumn:
                        $$CollectionItemsTableReferences._cardIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
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
    (CollectionItem, $$CollectionItemsTableReferences),
    CollectionItem,
    PrefetchHooks Function({bool cardId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CardsTableTableManager get cards =>
      $$CardsTableTableManager(_db, _db.cards);
  $$CollectionItemsTableTableManager get collectionItems =>
      $$CollectionItemsTableTableManager(_db, _db.collectionItems);
}
