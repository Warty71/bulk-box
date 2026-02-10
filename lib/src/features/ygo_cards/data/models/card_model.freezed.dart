// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CardModel {
  int get id;
  String get name;
  String get type;
  String get desc;
  String get race;
  String? get frameType;
  String? get attribute;
  int? get level;
  int? get atk;
  int? get def;
  String? get archetype;
  @JsonKey(name: 'card_images')
  List<CardImageModel> get cardImages;
  @JsonKey(name: 'card_sets', defaultValue: [])
  List<CardSetModel> get cardSets;

  /// Create a copy of CardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardModelCopyWith<CardModel> get copyWith =>
      _$CardModelCopyWithImpl<CardModel>(this as CardModel, _$identity);

  /// Serializes this CardModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.race, race) || other.race == race) &&
            (identical(other.frameType, frameType) ||
                other.frameType == frameType) &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.atk, atk) || other.atk == atk) &&
            (identical(other.def, def) || other.def == def) &&
            (identical(other.archetype, archetype) ||
                other.archetype == archetype) &&
            const DeepCollectionEquality()
                .equals(other.cardImages, cardImages) &&
            const DeepCollectionEquality().equals(other.cardSets, cardSets));
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
      frameType,
      attribute,
      level,
      atk,
      def,
      archetype,
      const DeepCollectionEquality().hash(cardImages),
      const DeepCollectionEquality().hash(cardSets));

  @override
  String toString() {
    return 'CardModel(id: $id, name: $name, type: $type, desc: $desc, race: $race, frameType: $frameType, attribute: $attribute, level: $level, atk: $atk, def: $def, archetype: $archetype, cardImages: $cardImages, cardSets: $cardSets)';
  }
}

/// @nodoc
abstract mixin class $CardModelCopyWith<$Res> {
  factory $CardModelCopyWith(CardModel value, $Res Function(CardModel) _then) =
      _$CardModelCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      String desc,
      String race,
      String? frameType,
      String? attribute,
      int? level,
      int? atk,
      int? def,
      String? archetype,
      @JsonKey(name: 'card_images') List<CardImageModel> cardImages,
      @JsonKey(name: 'card_sets', defaultValue: [])
      List<CardSetModel> cardSets});
}

/// @nodoc
class _$CardModelCopyWithImpl<$Res> implements $CardModelCopyWith<$Res> {
  _$CardModelCopyWithImpl(this._self, this._then);

  final CardModel _self;
  final $Res Function(CardModel) _then;

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
    Object? frameType = freezed,
    Object? attribute = freezed,
    Object? level = freezed,
    Object? atk = freezed,
    Object? def = freezed,
    Object? archetype = freezed,
    Object? cardImages = null,
    Object? cardSets = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _self.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      race: null == race
          ? _self.race
          : race // ignore: cast_nullable_to_non_nullable
              as String,
      frameType: freezed == frameType
          ? _self.frameType
          : frameType // ignore: cast_nullable_to_non_nullable
              as String?,
      attribute: freezed == attribute
          ? _self.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      atk: freezed == atk
          ? _self.atk
          : atk // ignore: cast_nullable_to_non_nullable
              as int?,
      def: freezed == def
          ? _self.def
          : def // ignore: cast_nullable_to_non_nullable
              as int?,
      archetype: freezed == archetype
          ? _self.archetype
          : archetype // ignore: cast_nullable_to_non_nullable
              as String?,
      cardImages: null == cardImages
          ? _self.cardImages
          : cardImages // ignore: cast_nullable_to_non_nullable
              as List<CardImageModel>,
      cardSets: null == cardSets
          ? _self.cardSets
          : cardSets // ignore: cast_nullable_to_non_nullable
              as List<CardSetModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [CardModel].
extension CardModelPatterns on CardModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CardModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CardModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CardModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            String name,
            String type,
            String desc,
            String race,
            String? frameType,
            String? attribute,
            int? level,
            int? atk,
            int? def,
            String? archetype,
            @JsonKey(name: 'card_images') List<CardImageModel> cardImages,
            @JsonKey(name: 'card_sets', defaultValue: [])
            List<CardSetModel> cardSets)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.desc,
            _that.race,
            _that.frameType,
            _that.attribute,
            _that.level,
            _that.atk,
            _that.def,
            _that.archetype,
            _that.cardImages,
            _that.cardSets);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            String name,
            String type,
            String desc,
            String race,
            String? frameType,
            String? attribute,
            int? level,
            int? atk,
            int? def,
            String? archetype,
            @JsonKey(name: 'card_images') List<CardImageModel> cardImages,
            @JsonKey(name: 'card_sets', defaultValue: [])
            List<CardSetModel> cardSets)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardModel():
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.desc,
            _that.race,
            _that.frameType,
            _that.attribute,
            _that.level,
            _that.atk,
            _that.def,
            _that.archetype,
            _that.cardImages,
            _that.cardSets);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            String name,
            String type,
            String desc,
            String race,
            String? frameType,
            String? attribute,
            int? level,
            int? atk,
            int? def,
            String? archetype,
            @JsonKey(name: 'card_images') List<CardImageModel> cardImages,
            @JsonKey(name: 'card_sets', defaultValue: [])
            List<CardSetModel> cardSets)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.desc,
            _that.race,
            _that.frameType,
            _that.attribute,
            _that.level,
            _that.atk,
            _that.def,
            _that.archetype,
            _that.cardImages,
            _that.cardSets);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CardModel implements CardModel {
  const _CardModel(
      {required this.id,
      required this.name,
      required this.type,
      required this.desc,
      required this.race,
      this.frameType,
      this.attribute,
      this.level,
      this.atk,
      this.def,
      this.archetype,
      @JsonKey(name: 'card_images')
      required final List<CardImageModel> cardImages,
      @JsonKey(name: 'card_sets', defaultValue: [])
      required final List<CardSetModel> cardSets})
      : _cardImages = cardImages,
        _cardSets = cardSets;
  factory _CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

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
  final String? frameType;
  @override
  final String? attribute;
  @override
  final int? level;
  @override
  final int? atk;
  @override
  final int? def;
  @override
  final String? archetype;
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
  @JsonKey(name: 'card_sets', defaultValue: [])
  List<CardSetModel> get cardSets {
    if (_cardSets is EqualUnmodifiableListView) return _cardSets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cardSets);
  }

  /// Create a copy of CardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CardModelCopyWith<_CardModel> get copyWith =>
      __$CardModelCopyWithImpl<_CardModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CardModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.race, race) || other.race == race) &&
            (identical(other.frameType, frameType) ||
                other.frameType == frameType) &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.atk, atk) || other.atk == atk) &&
            (identical(other.def, def) || other.def == def) &&
            (identical(other.archetype, archetype) ||
                other.archetype == archetype) &&
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
      frameType,
      attribute,
      level,
      atk,
      def,
      archetype,
      const DeepCollectionEquality().hash(_cardImages),
      const DeepCollectionEquality().hash(_cardSets));

  @override
  String toString() {
    return 'CardModel(id: $id, name: $name, type: $type, desc: $desc, race: $race, frameType: $frameType, attribute: $attribute, level: $level, atk: $atk, def: $def, archetype: $archetype, cardImages: $cardImages, cardSets: $cardSets)';
  }
}

/// @nodoc
abstract mixin class _$CardModelCopyWith<$Res>
    implements $CardModelCopyWith<$Res> {
  factory _$CardModelCopyWith(
          _CardModel value, $Res Function(_CardModel) _then) =
      __$CardModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      String desc,
      String race,
      String? frameType,
      String? attribute,
      int? level,
      int? atk,
      int? def,
      String? archetype,
      @JsonKey(name: 'card_images') List<CardImageModel> cardImages,
      @JsonKey(name: 'card_sets', defaultValue: [])
      List<CardSetModel> cardSets});
}

/// @nodoc
class __$CardModelCopyWithImpl<$Res> implements _$CardModelCopyWith<$Res> {
  __$CardModelCopyWithImpl(this._self, this._then);

  final _CardModel _self;
  final $Res Function(_CardModel) _then;

  /// Create a copy of CardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? desc = null,
    Object? race = null,
    Object? frameType = freezed,
    Object? attribute = freezed,
    Object? level = freezed,
    Object? atk = freezed,
    Object? def = freezed,
    Object? archetype = freezed,
    Object? cardImages = null,
    Object? cardSets = null,
  }) {
    return _then(_CardModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _self.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      race: null == race
          ? _self.race
          : race // ignore: cast_nullable_to_non_nullable
              as String,
      frameType: freezed == frameType
          ? _self.frameType
          : frameType // ignore: cast_nullable_to_non_nullable
              as String?,
      attribute: freezed == attribute
          ? _self.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      atk: freezed == atk
          ? _self.atk
          : atk // ignore: cast_nullable_to_non_nullable
              as int?,
      def: freezed == def
          ? _self.def
          : def // ignore: cast_nullable_to_non_nullable
              as int?,
      archetype: freezed == archetype
          ? _self.archetype
          : archetype // ignore: cast_nullable_to_non_nullable
              as String?,
      cardImages: null == cardImages
          ? _self._cardImages
          : cardImages // ignore: cast_nullable_to_non_nullable
              as List<CardImageModel>,
      cardSets: null == cardSets
          ? _self._cardSets
          : cardSets // ignore: cast_nullable_to_non_nullable
              as List<CardSetModel>,
    ));
  }
}

/// @nodoc
mixin _$CardImageModel {
  int get id;
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @JsonKey(name: 'image_url_small')
  String get imageUrlSmall;

  /// Create a copy of CardImageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardImageModelCopyWith<CardImageModel> get copyWith =>
      _$CardImageModelCopyWithImpl<CardImageModel>(
          this as CardImageModel, _$identity);

  /// Serializes this CardImageModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardImageModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.imageUrlSmall, imageUrlSmall) ||
                other.imageUrlSmall == imageUrlSmall));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, imageUrl, imageUrlSmall);

  @override
  String toString() {
    return 'CardImageModel(id: $id, imageUrl: $imageUrl, imageUrlSmall: $imageUrlSmall)';
  }
}

/// @nodoc
abstract mixin class $CardImageModelCopyWith<$Res> {
  factory $CardImageModelCopyWith(
          CardImageModel value, $Res Function(CardImageModel) _then) =
      _$CardImageModelCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'image_url') String imageUrl,
      @JsonKey(name: 'image_url_small') String imageUrlSmall});
}

/// @nodoc
class _$CardImageModelCopyWithImpl<$Res>
    implements $CardImageModelCopyWith<$Res> {
  _$CardImageModelCopyWithImpl(this._self, this._then);

  final CardImageModel _self;
  final $Res Function(CardImageModel) _then;

  /// Create a copy of CardImageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? imageUrlSmall = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrlSmall: null == imageUrlSmall
          ? _self.imageUrlSmall
          : imageUrlSmall // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [CardImageModel].
extension CardImageModelPatterns on CardImageModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CardImageModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardImageModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CardImageModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardImageModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CardImageModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardImageModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, @JsonKey(name: 'image_url') String imageUrl,
            @JsonKey(name: 'image_url_small') String imageUrlSmall)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardImageModel() when $default != null:
        return $default(_that.id, _that.imageUrl, _that.imageUrlSmall);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, @JsonKey(name: 'image_url') String imageUrl,
            @JsonKey(name: 'image_url_small') String imageUrlSmall)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardImageModel():
        return $default(_that.id, _that.imageUrl, _that.imageUrlSmall);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, @JsonKey(name: 'image_url') String imageUrl,
            @JsonKey(name: 'image_url_small') String imageUrlSmall)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardImageModel() when $default != null:
        return $default(_that.id, _that.imageUrl, _that.imageUrlSmall);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CardImageModel implements CardImageModel {
  const _CardImageModel(
      {required this.id,
      @JsonKey(name: 'image_url') required this.imageUrl,
      @JsonKey(name: 'image_url_small') required this.imageUrlSmall});
  factory _CardImageModel.fromJson(Map<String, dynamic> json) =>
      _$CardImageModelFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'image_url_small')
  final String imageUrlSmall;

  /// Create a copy of CardImageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CardImageModelCopyWith<_CardImageModel> get copyWith =>
      __$CardImageModelCopyWithImpl<_CardImageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardImageModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CardImageModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.imageUrlSmall, imageUrlSmall) ||
                other.imageUrlSmall == imageUrlSmall));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, imageUrl, imageUrlSmall);

  @override
  String toString() {
    return 'CardImageModel(id: $id, imageUrl: $imageUrl, imageUrlSmall: $imageUrlSmall)';
  }
}

/// @nodoc
abstract mixin class _$CardImageModelCopyWith<$Res>
    implements $CardImageModelCopyWith<$Res> {
  factory _$CardImageModelCopyWith(
          _CardImageModel value, $Res Function(_CardImageModel) _then) =
      __$CardImageModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'image_url') String imageUrl,
      @JsonKey(name: 'image_url_small') String imageUrlSmall});
}

/// @nodoc
class __$CardImageModelCopyWithImpl<$Res>
    implements _$CardImageModelCopyWith<$Res> {
  __$CardImageModelCopyWithImpl(this._self, this._then);

  final _CardImageModel _self;
  final $Res Function(_CardImageModel) _then;

  /// Create a copy of CardImageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? imageUrlSmall = null,
  }) {
    return _then(_CardImageModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrlSmall: null == imageUrlSmall
          ? _self.imageUrlSmall
          : imageUrlSmall // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$CardSetModel {
  @JsonKey(name: 'set_name')
  String get setName;
  @JsonKey(name: 'set_code')
  String get setCode;
  @JsonKey(name: 'set_rarity')
  String get setRarity;
  @JsonKey(name: 'set_edition')
  String? get setEdition;
  @JsonKey(name: 'set_price')
  String? get setPrice;
  @JsonKey(name: 'set_price_low')
  String? get setPriceLow;
  @JsonKey(name: 'set_url')
  String? get setUrl;

  /// Create a copy of CardSetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardSetModelCopyWith<CardSetModel> get copyWith =>
      _$CardSetModelCopyWithImpl<CardSetModel>(
          this as CardSetModel, _$identity);

  /// Serializes this CardSetModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardSetModel &&
            (identical(other.setName, setName) || other.setName == setName) &&
            (identical(other.setCode, setCode) || other.setCode == setCode) &&
            (identical(other.setRarity, setRarity) ||
                other.setRarity == setRarity) &&
            (identical(other.setEdition, setEdition) ||
                other.setEdition == setEdition) &&
            (identical(other.setPrice, setPrice) ||
                other.setPrice == setPrice) &&
            (identical(other.setPriceLow, setPriceLow) ||
                other.setPriceLow == setPriceLow) &&
            (identical(other.setUrl, setUrl) || other.setUrl == setUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, setName, setCode, setRarity,
      setEdition, setPrice, setPriceLow, setUrl);

  @override
  String toString() {
    return 'CardSetModel(setName: $setName, setCode: $setCode, setRarity: $setRarity, setEdition: $setEdition, setPrice: $setPrice, setPriceLow: $setPriceLow, setUrl: $setUrl)';
  }
}

/// @nodoc
abstract mixin class $CardSetModelCopyWith<$Res> {
  factory $CardSetModelCopyWith(
          CardSetModel value, $Res Function(CardSetModel) _then) =
      _$CardSetModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'set_name') String setName,
      @JsonKey(name: 'set_code') String setCode,
      @JsonKey(name: 'set_rarity') String setRarity,
      @JsonKey(name: 'set_edition') String? setEdition,
      @JsonKey(name: 'set_price') String? setPrice,
      @JsonKey(name: 'set_price_low') String? setPriceLow,
      @JsonKey(name: 'set_url') String? setUrl});
}

/// @nodoc
class _$CardSetModelCopyWithImpl<$Res> implements $CardSetModelCopyWith<$Res> {
  _$CardSetModelCopyWithImpl(this._self, this._then);

  final CardSetModel _self;
  final $Res Function(CardSetModel) _then;

  /// Create a copy of CardSetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setName = null,
    Object? setCode = null,
    Object? setRarity = null,
    Object? setEdition = freezed,
    Object? setPrice = freezed,
    Object? setPriceLow = freezed,
    Object? setUrl = freezed,
  }) {
    return _then(_self.copyWith(
      setName: null == setName
          ? _self.setName
          : setName // ignore: cast_nullable_to_non_nullable
              as String,
      setCode: null == setCode
          ? _self.setCode
          : setCode // ignore: cast_nullable_to_non_nullable
              as String,
      setRarity: null == setRarity
          ? _self.setRarity
          : setRarity // ignore: cast_nullable_to_non_nullable
              as String,
      setEdition: freezed == setEdition
          ? _self.setEdition
          : setEdition // ignore: cast_nullable_to_non_nullable
              as String?,
      setPrice: freezed == setPrice
          ? _self.setPrice
          : setPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      setPriceLow: freezed == setPriceLow
          ? _self.setPriceLow
          : setPriceLow // ignore: cast_nullable_to_non_nullable
              as String?,
      setUrl: freezed == setUrl
          ? _self.setUrl
          : setUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CardSetModel].
extension CardSetModelPatterns on CardSetModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CardSetModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardSetModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CardSetModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardSetModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CardSetModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardSetModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'set_name') String setName,
            @JsonKey(name: 'set_code') String setCode,
            @JsonKey(name: 'set_rarity') String setRarity,
            @JsonKey(name: 'set_edition') String? setEdition,
            @JsonKey(name: 'set_price') String? setPrice,
            @JsonKey(name: 'set_price_low') String? setPriceLow,
            @JsonKey(name: 'set_url') String? setUrl)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardSetModel() when $default != null:
        return $default(_that.setName, _that.setCode, _that.setRarity,
            _that.setEdition, _that.setPrice, _that.setPriceLow, _that.setUrl);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'set_name') String setName,
            @JsonKey(name: 'set_code') String setCode,
            @JsonKey(name: 'set_rarity') String setRarity,
            @JsonKey(name: 'set_edition') String? setEdition,
            @JsonKey(name: 'set_price') String? setPrice,
            @JsonKey(name: 'set_price_low') String? setPriceLow,
            @JsonKey(name: 'set_url') String? setUrl)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardSetModel():
        return $default(_that.setName, _that.setCode, _that.setRarity,
            _that.setEdition, _that.setPrice, _that.setPriceLow, _that.setUrl);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: 'set_name') String setName,
            @JsonKey(name: 'set_code') String setCode,
            @JsonKey(name: 'set_rarity') String setRarity,
            @JsonKey(name: 'set_edition') String? setEdition,
            @JsonKey(name: 'set_price') String? setPrice,
            @JsonKey(name: 'set_price_low') String? setPriceLow,
            @JsonKey(name: 'set_url') String? setUrl)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardSetModel() when $default != null:
        return $default(_that.setName, _that.setCode, _that.setRarity,
            _that.setEdition, _that.setPrice, _that.setPriceLow, _that.setUrl);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CardSetModel implements CardSetModel {
  const _CardSetModel(
      {@JsonKey(name: 'set_name') required this.setName,
      @JsonKey(name: 'set_code') required this.setCode,
      @JsonKey(name: 'set_rarity') required this.setRarity,
      @JsonKey(name: 'set_edition') this.setEdition,
      @JsonKey(name: 'set_price') this.setPrice,
      @JsonKey(name: 'set_price_low') this.setPriceLow,
      @JsonKey(name: 'set_url') this.setUrl});
  factory _CardSetModel.fromJson(Map<String, dynamic> json) =>
      _$CardSetModelFromJson(json);

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
  @JsonKey(name: 'set_edition')
  final String? setEdition;
  @override
  @JsonKey(name: 'set_price')
  final String? setPrice;
  @override
  @JsonKey(name: 'set_price_low')
  final String? setPriceLow;
  @override
  @JsonKey(name: 'set_url')
  final String? setUrl;

  /// Create a copy of CardSetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CardSetModelCopyWith<_CardSetModel> get copyWith =>
      __$CardSetModelCopyWithImpl<_CardSetModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardSetModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CardSetModel &&
            (identical(other.setName, setName) || other.setName == setName) &&
            (identical(other.setCode, setCode) || other.setCode == setCode) &&
            (identical(other.setRarity, setRarity) ||
                other.setRarity == setRarity) &&
            (identical(other.setEdition, setEdition) ||
                other.setEdition == setEdition) &&
            (identical(other.setPrice, setPrice) ||
                other.setPrice == setPrice) &&
            (identical(other.setPriceLow, setPriceLow) ||
                other.setPriceLow == setPriceLow) &&
            (identical(other.setUrl, setUrl) || other.setUrl == setUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, setName, setCode, setRarity,
      setEdition, setPrice, setPriceLow, setUrl);

  @override
  String toString() {
    return 'CardSetModel(setName: $setName, setCode: $setCode, setRarity: $setRarity, setEdition: $setEdition, setPrice: $setPrice, setPriceLow: $setPriceLow, setUrl: $setUrl)';
  }
}

/// @nodoc
abstract mixin class _$CardSetModelCopyWith<$Res>
    implements $CardSetModelCopyWith<$Res> {
  factory _$CardSetModelCopyWith(
          _CardSetModel value, $Res Function(_CardSetModel) _then) =
      __$CardSetModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'set_name') String setName,
      @JsonKey(name: 'set_code') String setCode,
      @JsonKey(name: 'set_rarity') String setRarity,
      @JsonKey(name: 'set_edition') String? setEdition,
      @JsonKey(name: 'set_price') String? setPrice,
      @JsonKey(name: 'set_price_low') String? setPriceLow,
      @JsonKey(name: 'set_url') String? setUrl});
}

/// @nodoc
class __$CardSetModelCopyWithImpl<$Res>
    implements _$CardSetModelCopyWith<$Res> {
  __$CardSetModelCopyWithImpl(this._self, this._then);

  final _CardSetModel _self;
  final $Res Function(_CardSetModel) _then;

  /// Create a copy of CardSetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? setName = null,
    Object? setCode = null,
    Object? setRarity = null,
    Object? setEdition = freezed,
    Object? setPrice = freezed,
    Object? setPriceLow = freezed,
    Object? setUrl = freezed,
  }) {
    return _then(_CardSetModel(
      setName: null == setName
          ? _self.setName
          : setName // ignore: cast_nullable_to_non_nullable
              as String,
      setCode: null == setCode
          ? _self.setCode
          : setCode // ignore: cast_nullable_to_non_nullable
              as String,
      setRarity: null == setRarity
          ? _self.setRarity
          : setRarity // ignore: cast_nullable_to_non_nullable
              as String,
      setEdition: freezed == setEdition
          ? _self.setEdition
          : setEdition // ignore: cast_nullable_to_non_nullable
              as String?,
      setPrice: freezed == setPrice
          ? _self.setPrice
          : setPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      setPriceLow: freezed == setPriceLow
          ? _self.setPriceLow
          : setPriceLow // ignore: cast_nullable_to_non_nullable
              as String?,
      setUrl: freezed == setUrl
          ? _self.setUrl
          : setUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
