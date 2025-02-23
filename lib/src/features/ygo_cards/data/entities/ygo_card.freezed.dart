// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ygo_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

YgoCard _$YgoCardFromJson(Map<String, dynamic> json) {
  return _YgoCard.fromJson(json);
}

/// @nodoc
mixin _$YgoCard {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get race => throw _privateConstructorUsedError;
  String? get attribute => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;
  int? get atk => throw _privateConstructorUsedError;
  int? get def => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<CardSet> get cardSets => throw _privateConstructorUsedError;
  bool get isLocalImageAvailable => throw _privateConstructorUsedError;

  /// Serializes this YgoCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YgoCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YgoCardCopyWith<YgoCard> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YgoCardCopyWith<$Res> {
  factory $YgoCardCopyWith(YgoCard value, $Res Function(YgoCard) then) =
      _$YgoCardCopyWithImpl<$Res, YgoCard>;
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      String description,
      String race,
      String? attribute,
      int? level,
      int? atk,
      int? def,
      String imageUrl,
      List<CardSet> cardSets,
      bool isLocalImageAvailable});
}

/// @nodoc
class _$YgoCardCopyWithImpl<$Res, $Val extends YgoCard>
    implements $YgoCardCopyWith<$Res> {
  _$YgoCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YgoCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? description = null,
    Object? race = null,
    Object? attribute = freezed,
    Object? level = freezed,
    Object? atk = freezed,
    Object? def = freezed,
    Object? imageUrl = null,
    Object? cardSets = null,
    Object? isLocalImageAvailable = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      race: null == race
          ? _value.race
          : race // ignore: cast_nullable_to_non_nullable
              as String,
      attribute: freezed == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      atk: freezed == atk
          ? _value.atk
          : atk // ignore: cast_nullable_to_non_nullable
              as int?,
      def: freezed == def
          ? _value.def
          : def // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      cardSets: null == cardSets
          ? _value.cardSets
          : cardSets // ignore: cast_nullable_to_non_nullable
              as List<CardSet>,
      isLocalImageAvailable: null == isLocalImageAvailable
          ? _value.isLocalImageAvailable
          : isLocalImageAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$YgoCardImplCopyWith<$Res> implements $YgoCardCopyWith<$Res> {
  factory _$$YgoCardImplCopyWith(
          _$YgoCardImpl value, $Res Function(_$YgoCardImpl) then) =
      __$$YgoCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      String description,
      String race,
      String? attribute,
      int? level,
      int? atk,
      int? def,
      String imageUrl,
      List<CardSet> cardSets,
      bool isLocalImageAvailable});
}

/// @nodoc
class __$$YgoCardImplCopyWithImpl<$Res>
    extends _$YgoCardCopyWithImpl<$Res, _$YgoCardImpl>
    implements _$$YgoCardImplCopyWith<$Res> {
  __$$YgoCardImplCopyWithImpl(
      _$YgoCardImpl _value, $Res Function(_$YgoCardImpl) _then)
      : super(_value, _then);

  /// Create a copy of YgoCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? description = null,
    Object? race = null,
    Object? attribute = freezed,
    Object? level = freezed,
    Object? atk = freezed,
    Object? def = freezed,
    Object? imageUrl = null,
    Object? cardSets = null,
    Object? isLocalImageAvailable = null,
  }) {
    return _then(_$YgoCardImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      race: null == race
          ? _value.race
          : race // ignore: cast_nullable_to_non_nullable
              as String,
      attribute: freezed == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      atk: freezed == atk
          ? _value.atk
          : atk // ignore: cast_nullable_to_non_nullable
              as int?,
      def: freezed == def
          ? _value.def
          : def // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      cardSets: null == cardSets
          ? _value._cardSets
          : cardSets // ignore: cast_nullable_to_non_nullable
              as List<CardSet>,
      isLocalImageAvailable: null == isLocalImageAvailable
          ? _value.isLocalImageAvailable
          : isLocalImageAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YgoCardImpl implements _YgoCard {
  const _$YgoCardImpl(
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
      required final List<CardSet> cardSets,
      this.isLocalImageAvailable = false})
      : _cardSets = cardSets;

  factory _$YgoCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$YgoCardImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String type;
  @override
  final String description;
  @override
  final String race;
  @override
  final String? attribute;
  @override
  final int? level;
  @override
  final int? atk;
  @override
  final int? def;
  @override
  final String imageUrl;
  final List<CardSet> _cardSets;
  @override
  List<CardSet> get cardSets {
    if (_cardSets is EqualUnmodifiableListView) return _cardSets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cardSets);
  }

  @override
  @JsonKey()
  final bool isLocalImageAvailable;

  @override
  String toString() {
    return 'YgoCard(id: $id, name: $name, type: $type, description: $description, race: $race, attribute: $attribute, level: $level, atk: $atk, def: $def, imageUrl: $imageUrl, cardSets: $cardSets, isLocalImageAvailable: $isLocalImageAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YgoCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.race, race) || other.race == race) &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.atk, atk) || other.atk == atk) &&
            (identical(other.def, def) || other.def == def) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._cardSets, _cardSets) &&
            (identical(other.isLocalImageAvailable, isLocalImageAvailable) ||
                other.isLocalImageAvailable == isLocalImageAvailable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
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
      const DeepCollectionEquality().hash(_cardSets),
      isLocalImageAvailable);

  /// Create a copy of YgoCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YgoCardImplCopyWith<_$YgoCardImpl> get copyWith =>
      __$$YgoCardImplCopyWithImpl<_$YgoCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YgoCardImplToJson(
      this,
    );
  }
}

abstract class _YgoCard implements YgoCard {
  const factory _YgoCard(
      {required final int id,
      required final String name,
      required final String type,
      required final String description,
      required final String race,
      final String? attribute,
      final int? level,
      final int? atk,
      final int? def,
      required final String imageUrl,
      required final List<CardSet> cardSets,
      final bool isLocalImageAvailable}) = _$YgoCardImpl;

  factory _YgoCard.fromJson(Map<String, dynamic> json) = _$YgoCardImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get type;
  @override
  String get description;
  @override
  String get race;
  @override
  String? get attribute;
  @override
  int? get level;
  @override
  int? get atk;
  @override
  int? get def;
  @override
  String get imageUrl;
  @override
  List<CardSet> get cardSets;
  @override
  bool get isLocalImageAvailable;

  /// Create a copy of YgoCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YgoCardImplCopyWith<_$YgoCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CardSet _$CardSetFromJson(Map<String, dynamic> json) {
  return _CardSet.fromJson(json);
}

/// @nodoc
mixin _$CardSet {
  String get setName => throw _privateConstructorUsedError;
  String get setCode => throw _privateConstructorUsedError;
  String get setRarity => throw _privateConstructorUsedError;
  String get setPrice => throw _privateConstructorUsedError;

  /// Serializes this CardSet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CardSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CardSetCopyWith<CardSet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardSetCopyWith<$Res> {
  factory $CardSetCopyWith(CardSet value, $Res Function(CardSet) then) =
      _$CardSetCopyWithImpl<$Res, CardSet>;
  @useResult
  $Res call(
      {String setName, String setCode, String setRarity, String setPrice});
}

/// @nodoc
class _$CardSetCopyWithImpl<$Res, $Val extends CardSet>
    implements $CardSetCopyWith<$Res> {
  _$CardSetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CardSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setName = null,
    Object? setCode = null,
    Object? setRarity = null,
    Object? setPrice = null,
  }) {
    return _then(_value.copyWith(
      setName: null == setName
          ? _value.setName
          : setName // ignore: cast_nullable_to_non_nullable
              as String,
      setCode: null == setCode
          ? _value.setCode
          : setCode // ignore: cast_nullable_to_non_nullable
              as String,
      setRarity: null == setRarity
          ? _value.setRarity
          : setRarity // ignore: cast_nullable_to_non_nullable
              as String,
      setPrice: null == setPrice
          ? _value.setPrice
          : setPrice // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CardSetImplCopyWith<$Res> implements $CardSetCopyWith<$Res> {
  factory _$$CardSetImplCopyWith(
          _$CardSetImpl value, $Res Function(_$CardSetImpl) then) =
      __$$CardSetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String setName, String setCode, String setRarity, String setPrice});
}

/// @nodoc
class __$$CardSetImplCopyWithImpl<$Res>
    extends _$CardSetCopyWithImpl<$Res, _$CardSetImpl>
    implements _$$CardSetImplCopyWith<$Res> {
  __$$CardSetImplCopyWithImpl(
      _$CardSetImpl _value, $Res Function(_$CardSetImpl) _then)
      : super(_value, _then);

  /// Create a copy of CardSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setName = null,
    Object? setCode = null,
    Object? setRarity = null,
    Object? setPrice = null,
  }) {
    return _then(_$CardSetImpl(
      setName: null == setName
          ? _value.setName
          : setName // ignore: cast_nullable_to_non_nullable
              as String,
      setCode: null == setCode
          ? _value.setCode
          : setCode // ignore: cast_nullable_to_non_nullable
              as String,
      setRarity: null == setRarity
          ? _value.setRarity
          : setRarity // ignore: cast_nullable_to_non_nullable
              as String,
      setPrice: null == setPrice
          ? _value.setPrice
          : setPrice // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CardSetImpl implements _CardSet {
  const _$CardSetImpl(
      {required this.setName,
      required this.setCode,
      required this.setRarity,
      required this.setPrice});

  factory _$CardSetImpl.fromJson(Map<String, dynamic> json) =>
      _$$CardSetImplFromJson(json);

  @override
  final String setName;
  @override
  final String setCode;
  @override
  final String setRarity;
  @override
  final String setPrice;

  @override
  String toString() {
    return 'CardSet(setName: $setName, setCode: $setCode, setRarity: $setRarity, setPrice: $setPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardSetImpl &&
            (identical(other.setName, setName) || other.setName == setName) &&
            (identical(other.setCode, setCode) || other.setCode == setCode) &&
            (identical(other.setRarity, setRarity) ||
                other.setRarity == setRarity) &&
            (identical(other.setPrice, setPrice) ||
                other.setPrice == setPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, setName, setCode, setRarity, setPrice);

  /// Create a copy of CardSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CardSetImplCopyWith<_$CardSetImpl> get copyWith =>
      __$$CardSetImplCopyWithImpl<_$CardSetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CardSetImplToJson(
      this,
    );
  }
}

abstract class _CardSet implements CardSet {
  const factory _CardSet(
      {required final String setName,
      required final String setCode,
      required final String setRarity,
      required final String setPrice}) = _$CardSetImpl;

  factory _CardSet.fromJson(Map<String, dynamic> json) = _$CardSetImpl.fromJson;

  @override
  String get setName;
  @override
  String get setCode;
  @override
  String get setRarity;
  @override
  String get setPrice;

  /// Create a copy of CardSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CardSetImplCopyWith<_$CardSetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
