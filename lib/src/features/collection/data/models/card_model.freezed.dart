// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CardModel _$CardModelFromJson(Map<String, dynamic> json) {
  return _CardModel.fromJson(json);
}

/// @nodoc
mixin _$CardModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;
  String get race => throw _privateConstructorUsedError;
  String? get attribute => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;
  int? get atk => throw _privateConstructorUsedError;
  int? get def => throw _privateConstructorUsedError;
  @JsonKey(name: 'card_images')
  List<CardImageModel> get cardImages => throw _privateConstructorUsedError;
  @JsonKey(name: 'card_sets')
  List<CardSetModel> get cardSets => throw _privateConstructorUsedError;

  /// Serializes this CardModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CardModelCopyWith<CardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardModelCopyWith<$Res> {
  factory $CardModelCopyWith(CardModel value, $Res Function(CardModel) then) =
      _$CardModelCopyWithImpl<$Res, CardModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      String desc,
      String race,
      String? attribute,
      int? level,
      int? atk,
      int? def,
      @JsonKey(name: 'card_images') List<CardImageModel> cardImages,
      @JsonKey(name: 'card_sets') List<CardSetModel> cardSets});
}

/// @nodoc
class _$CardModelCopyWithImpl<$Res, $Val extends CardModel>
    implements $CardModelCopyWith<$Res> {
  _$CardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? desc = null,
    Object? race = null,
    Object? attribute = freezed,
    Object? level = freezed,
    Object? atk = freezed,
    Object? def = freezed,
    Object? cardImages = null,
    Object? cardSets = null,
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
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
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
      cardImages: null == cardImages
          ? _value.cardImages
          : cardImages // ignore: cast_nullable_to_non_nullable
              as List<CardImageModel>,
      cardSets: null == cardSets
          ? _value.cardSets
          : cardSets // ignore: cast_nullable_to_non_nullable
              as List<CardSetModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CardModelImplCopyWith<$Res>
    implements $CardModelCopyWith<$Res> {
  factory _$$CardModelImplCopyWith(
          _$CardModelImpl value, $Res Function(_$CardModelImpl) then) =
      __$$CardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      String desc,
      String race,
      String? attribute,
      int? level,
      int? atk,
      int? def,
      @JsonKey(name: 'card_images') List<CardImageModel> cardImages,
      @JsonKey(name: 'card_sets') List<CardSetModel> cardSets});
}

/// @nodoc
class __$$CardModelImplCopyWithImpl<$Res>
    extends _$CardModelCopyWithImpl<$Res, _$CardModelImpl>
    implements _$$CardModelImplCopyWith<$Res> {
  __$$CardModelImplCopyWithImpl(
      _$CardModelImpl _value, $Res Function(_$CardModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? desc = null,
    Object? race = null,
    Object? attribute = freezed,
    Object? level = freezed,
    Object? atk = freezed,
    Object? def = freezed,
    Object? cardImages = null,
    Object? cardSets = null,
  }) {
    return _then(_$CardModelImpl(
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
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
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
      cardImages: null == cardImages
          ? _value._cardImages
          : cardImages // ignore: cast_nullable_to_non_nullable
              as List<CardImageModel>,
      cardSets: null == cardSets
          ? _value._cardSets
          : cardSets // ignore: cast_nullable_to_non_nullable
              as List<CardSetModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CardModelImpl implements _CardModel {
  const _$CardModelImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.desc,
      required this.race,
      this.attribute,
      this.level,
      this.atk,
      this.def,
      @JsonKey(name: 'card_images')
      required final List<CardImageModel> cardImages,
      @JsonKey(name: 'card_sets') required final List<CardSetModel> cardSets})
      : _cardImages = cardImages,
        _cardSets = cardSets;

  factory _$CardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CardModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String type;
  @override
  final String desc;
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
  final List<CardImageModel> _cardImages;
  @override
  @JsonKey(name: 'card_images')
  List<CardImageModel> get cardImages {
    if (_cardImages is EqualUnmodifiableListView) return _cardImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cardImages);
  }

  final List<CardSetModel> _cardSets;
  @override
  @JsonKey(name: 'card_sets')
  List<CardSetModel> get cardSets {
    if (_cardSets is EqualUnmodifiableListView) return _cardSets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cardSets);
  }

  @override
  String toString() {
    return 'CardModel(id: $id, name: $name, type: $type, desc: $desc, race: $race, attribute: $attribute, level: $level, atk: $atk, def: $def, cardImages: $cardImages, cardSets: $cardSets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.race, race) || other.race == race) &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.atk, atk) || other.atk == atk) &&
            (identical(other.def, def) || other.def == def) &&
            const DeepCollectionEquality()
                .equals(other._cardImages, _cardImages) &&
            const DeepCollectionEquality().equals(other._cardSets, _cardSets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      desc,
      race,
      attribute,
      level,
      atk,
      def,
      const DeepCollectionEquality().hash(_cardImages),
      const DeepCollectionEquality().hash(_cardSets));

  /// Create a copy of CardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CardModelImplCopyWith<_$CardModelImpl> get copyWith =>
      __$$CardModelImplCopyWithImpl<_$CardModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CardModelImplToJson(
      this,
    );
  }
}

abstract class _CardModel implements CardModel {
  const factory _CardModel(
      {required final int id,
      required final String name,
      required final String type,
      required final String desc,
      required final String race,
      final String? attribute,
      final int? level,
      final int? atk,
      final int? def,
      @JsonKey(name: 'card_images')
      required final List<CardImageModel> cardImages,
      @JsonKey(name: 'card_sets')
      required final List<CardSetModel> cardSets}) = _$CardModelImpl;

  factory _CardModel.fromJson(Map<String, dynamic> json) =
      _$CardModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get type;
  @override
  String get desc;
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
  @JsonKey(name: 'card_images')
  List<CardImageModel> get cardImages;
  @override
  @JsonKey(name: 'card_sets')
  List<CardSetModel> get cardSets;

  /// Create a copy of CardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CardModelImplCopyWith<_$CardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CardImageModel _$CardImageModelFromJson(Map<String, dynamic> json) {
  return _CardImageModel.fromJson(json);
}

/// @nodoc
mixin _$CardImageModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url_small')
  String get imageUrlSmall => throw _privateConstructorUsedError;

  /// Serializes this CardImageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CardImageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CardImageModelCopyWith<CardImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardImageModelCopyWith<$Res> {
  factory $CardImageModelCopyWith(
          CardImageModel value, $Res Function(CardImageModel) then) =
      _$CardImageModelCopyWithImpl<$Res, CardImageModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'image_url') String imageUrl,
      @JsonKey(name: 'image_url_small') String imageUrlSmall});
}

/// @nodoc
class _$CardImageModelCopyWithImpl<$Res, $Val extends CardImageModel>
    implements $CardImageModelCopyWith<$Res> {
  _$CardImageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CardImageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? imageUrlSmall = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrlSmall: null == imageUrlSmall
          ? _value.imageUrlSmall
          : imageUrlSmall // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CardImageModelImplCopyWith<$Res>
    implements $CardImageModelCopyWith<$Res> {
  factory _$$CardImageModelImplCopyWith(_$CardImageModelImpl value,
          $Res Function(_$CardImageModelImpl) then) =
      __$$CardImageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'image_url') String imageUrl,
      @JsonKey(name: 'image_url_small') String imageUrlSmall});
}

/// @nodoc
class __$$CardImageModelImplCopyWithImpl<$Res>
    extends _$CardImageModelCopyWithImpl<$Res, _$CardImageModelImpl>
    implements _$$CardImageModelImplCopyWith<$Res> {
  __$$CardImageModelImplCopyWithImpl(
      _$CardImageModelImpl _value, $Res Function(_$CardImageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CardImageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? imageUrlSmall = null,
  }) {
    return _then(_$CardImageModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrlSmall: null == imageUrlSmall
          ? _value.imageUrlSmall
          : imageUrlSmall // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CardImageModelImpl implements _CardImageModel {
  const _$CardImageModelImpl(
      {required this.id,
      @JsonKey(name: 'image_url') required this.imageUrl,
      @JsonKey(name: 'image_url_small') required this.imageUrlSmall});

  factory _$CardImageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CardImageModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'image_url_small')
  final String imageUrlSmall;

  @override
  String toString() {
    return 'CardImageModel(id: $id, imageUrl: $imageUrl, imageUrlSmall: $imageUrlSmall)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardImageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.imageUrlSmall, imageUrlSmall) ||
                other.imageUrlSmall == imageUrlSmall));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, imageUrl, imageUrlSmall);

  /// Create a copy of CardImageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CardImageModelImplCopyWith<_$CardImageModelImpl> get copyWith =>
      __$$CardImageModelImplCopyWithImpl<_$CardImageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CardImageModelImplToJson(
      this,
    );
  }
}

abstract class _CardImageModel implements CardImageModel {
  const factory _CardImageModel(
      {required final int id,
      @JsonKey(name: 'image_url') required final String imageUrl,
      @JsonKey(name: 'image_url_small')
      required final String imageUrlSmall}) = _$CardImageModelImpl;

  factory _CardImageModel.fromJson(Map<String, dynamic> json) =
      _$CardImageModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @JsonKey(name: 'image_url_small')
  String get imageUrlSmall;

  /// Create a copy of CardImageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CardImageModelImplCopyWith<_$CardImageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CardSetModel _$CardSetModelFromJson(Map<String, dynamic> json) {
  return _CardSetModel.fromJson(json);
}

/// @nodoc
mixin _$CardSetModel {
  @JsonKey(name: 'set_name')
  String get setName => throw _privateConstructorUsedError;
  @JsonKey(name: 'set_code')
  String get setCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'set_rarity')
  String get setRarity => throw _privateConstructorUsedError;
  @JsonKey(name: 'set_price')
  String get setPrice => throw _privateConstructorUsedError;

  /// Serializes this CardSetModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CardSetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CardSetModelCopyWith<CardSetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardSetModelCopyWith<$Res> {
  factory $CardSetModelCopyWith(
          CardSetModel value, $Res Function(CardSetModel) then) =
      _$CardSetModelCopyWithImpl<$Res, CardSetModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'set_name') String setName,
      @JsonKey(name: 'set_code') String setCode,
      @JsonKey(name: 'set_rarity') String setRarity,
      @JsonKey(name: 'set_price') String setPrice});
}

/// @nodoc
class _$CardSetModelCopyWithImpl<$Res, $Val extends CardSetModel>
    implements $CardSetModelCopyWith<$Res> {
  _$CardSetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CardSetModel
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
abstract class _$$CardSetModelImplCopyWith<$Res>
    implements $CardSetModelCopyWith<$Res> {
  factory _$$CardSetModelImplCopyWith(
          _$CardSetModelImpl value, $Res Function(_$CardSetModelImpl) then) =
      __$$CardSetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'set_name') String setName,
      @JsonKey(name: 'set_code') String setCode,
      @JsonKey(name: 'set_rarity') String setRarity,
      @JsonKey(name: 'set_price') String setPrice});
}

/// @nodoc
class __$$CardSetModelImplCopyWithImpl<$Res>
    extends _$CardSetModelCopyWithImpl<$Res, _$CardSetModelImpl>
    implements _$$CardSetModelImplCopyWith<$Res> {
  __$$CardSetModelImplCopyWithImpl(
      _$CardSetModelImpl _value, $Res Function(_$CardSetModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CardSetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setName = null,
    Object? setCode = null,
    Object? setRarity = null,
    Object? setPrice = null,
  }) {
    return _then(_$CardSetModelImpl(
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
class _$CardSetModelImpl implements _CardSetModel {
  const _$CardSetModelImpl(
      {@JsonKey(name: 'set_name') required this.setName,
      @JsonKey(name: 'set_code') required this.setCode,
      @JsonKey(name: 'set_rarity') required this.setRarity,
      @JsonKey(name: 'set_price') required this.setPrice});

  factory _$CardSetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CardSetModelImplFromJson(json);

  @override
  @JsonKey(name: 'set_name')
  final String setName;
  @override
  @JsonKey(name: 'set_code')
  final String setCode;
  @override
  @JsonKey(name: 'set_rarity')
  final String setRarity;
  @override
  @JsonKey(name: 'set_price')
  final String setPrice;

  @override
  String toString() {
    return 'CardSetModel(setName: $setName, setCode: $setCode, setRarity: $setRarity, setPrice: $setPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardSetModelImpl &&
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

  /// Create a copy of CardSetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CardSetModelImplCopyWith<_$CardSetModelImpl> get copyWith =>
      __$$CardSetModelImplCopyWithImpl<_$CardSetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CardSetModelImplToJson(
      this,
    );
  }
}

abstract class _CardSetModel implements CardSetModel {
  const factory _CardSetModel(
          {@JsonKey(name: 'set_name') required final String setName,
          @JsonKey(name: 'set_code') required final String setCode,
          @JsonKey(name: 'set_rarity') required final String setRarity,
          @JsonKey(name: 'set_price') required final String setPrice}) =
      _$CardSetModelImpl;

  factory _CardSetModel.fromJson(Map<String, dynamic> json) =
      _$CardSetModelImpl.fromJson;

  @override
  @JsonKey(name: 'set_name')
  String get setName;
  @override
  @JsonKey(name: 'set_code')
  String get setCode;
  @override
  @JsonKey(name: 'set_rarity')
  String get setRarity;
  @override
  @JsonKey(name: 'set_price')
  String get setPrice;

  /// Create a copy of CardSetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CardSetModelImplCopyWith<_$CardSetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
