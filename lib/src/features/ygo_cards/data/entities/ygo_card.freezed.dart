// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ygo_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YgoCard {
  int get id;
  String get name;
  String get type;
  String get description;
  String get race;
  String? get attribute;
  int? get level;
  int? get atk;
  int? get def;
  String get imageUrl;
  List<CardSet> get cardSets;
  bool get isLocalImageAvailable;

  /// Create a copy of YgoCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $YgoCardCopyWith<YgoCard> get copyWith =>
      _$YgoCardCopyWithImpl<YgoCard>(this as YgoCard, _$identity);

  /// Serializes this YgoCard to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is YgoCard &&
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
            const DeepCollectionEquality().equals(other.cardSets, cardSets) &&
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
      const DeepCollectionEquality().hash(cardSets),
      isLocalImageAvailable);

  @override
  String toString() {
    return 'YgoCard(id: $id, name: $name, type: $type, description: $description, race: $race, attribute: $attribute, level: $level, atk: $atk, def: $def, imageUrl: $imageUrl, cardSets: $cardSets, isLocalImageAvailable: $isLocalImageAvailable)';
  }
}

/// @nodoc
abstract mixin class $YgoCardCopyWith<$Res> {
  factory $YgoCardCopyWith(YgoCard value, $Res Function(YgoCard) _then) =
      _$YgoCardCopyWithImpl;
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
class _$YgoCardCopyWithImpl<$Res> implements $YgoCardCopyWith<$Res> {
  _$YgoCardCopyWithImpl(this._self, this._then);

  final YgoCard _self;
  final $Res Function(YgoCard) _then;

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
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      race: null == race
          ? _self.race
          : race // ignore: cast_nullable_to_non_nullable
              as String,
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
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      cardSets: null == cardSets
          ? _self.cardSets
          : cardSets // ignore: cast_nullable_to_non_nullable
              as List<CardSet>,
      isLocalImageAvailable: null == isLocalImageAvailable
          ? _self.isLocalImageAvailable
          : isLocalImageAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [YgoCard].
extension YgoCardPatterns on YgoCard {
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
    TResult Function(_YgoCard value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YgoCard() when $default != null:
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
    TResult Function(_YgoCard value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YgoCard():
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
    TResult? Function(_YgoCard value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YgoCard() when $default != null:
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
            String description,
            String race,
            String? attribute,
            int? level,
            int? atk,
            int? def,
            String imageUrl,
            List<CardSet> cardSets,
            bool isLocalImageAvailable)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YgoCard() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.description,
            _that.race,
            _that.attribute,
            _that.level,
            _that.atk,
            _that.def,
            _that.imageUrl,
            _that.cardSets,
            _that.isLocalImageAvailable);
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
            String description,
            String race,
            String? attribute,
            int? level,
            int? atk,
            int? def,
            String imageUrl,
            List<CardSet> cardSets,
            bool isLocalImageAvailable)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YgoCard():
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.description,
            _that.race,
            _that.attribute,
            _that.level,
            _that.atk,
            _that.def,
            _that.imageUrl,
            _that.cardSets,
            _that.isLocalImageAvailable);
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
            String description,
            String race,
            String? attribute,
            int? level,
            int? atk,
            int? def,
            String imageUrl,
            List<CardSet> cardSets,
            bool isLocalImageAvailable)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YgoCard() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.description,
            _that.race,
            _that.attribute,
            _that.level,
            _that.atk,
            _that.def,
            _that.imageUrl,
            _that.cardSets,
            _that.isLocalImageAvailable);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _YgoCard implements YgoCard {
  const _YgoCard(
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
  factory _YgoCard.fromJson(Map<String, dynamic> json) =>
      _$YgoCardFromJson(json);

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

  /// Create a copy of YgoCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$YgoCardCopyWith<_YgoCard> get copyWith =>
      __$YgoCardCopyWithImpl<_YgoCard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$YgoCardToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _YgoCard &&
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

  @override
  String toString() {
    return 'YgoCard(id: $id, name: $name, type: $type, description: $description, race: $race, attribute: $attribute, level: $level, atk: $atk, def: $def, imageUrl: $imageUrl, cardSets: $cardSets, isLocalImageAvailable: $isLocalImageAvailable)';
  }
}

/// @nodoc
abstract mixin class _$YgoCardCopyWith<$Res> implements $YgoCardCopyWith<$Res> {
  factory _$YgoCardCopyWith(_YgoCard value, $Res Function(_YgoCard) _then) =
      __$YgoCardCopyWithImpl;
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
class __$YgoCardCopyWithImpl<$Res> implements _$YgoCardCopyWith<$Res> {
  __$YgoCardCopyWithImpl(this._self, this._then);

  final _YgoCard _self;
  final $Res Function(_YgoCard) _then;

  /// Create a copy of YgoCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_YgoCard(
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
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      race: null == race
          ? _self.race
          : race // ignore: cast_nullable_to_non_nullable
              as String,
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
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      cardSets: null == cardSets
          ? _self._cardSets
          : cardSets // ignore: cast_nullable_to_non_nullable
              as List<CardSet>,
      isLocalImageAvailable: null == isLocalImageAvailable
          ? _self.isLocalImageAvailable
          : isLocalImageAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$CardSet {
  String get setName;
  String get setCode;
  String get setRarity;

  /// Create a copy of CardSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardSetCopyWith<CardSet> get copyWith =>
      _$CardSetCopyWithImpl<CardSet>(this as CardSet, _$identity);

  /// Serializes this CardSet to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardSet &&
            (identical(other.setName, setName) || other.setName == setName) &&
            (identical(other.setCode, setCode) || other.setCode == setCode) &&
            (identical(other.setRarity, setRarity) ||
                other.setRarity == setRarity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, setName, setCode, setRarity);

  @override
  String toString() {
    return 'CardSet(setName: $setName, setCode: $setCode, setRarity: $setRarity)';
  }
}

/// @nodoc
abstract mixin class $CardSetCopyWith<$Res> {
  factory $CardSetCopyWith(CardSet value, $Res Function(CardSet) _then) =
      _$CardSetCopyWithImpl;
  @useResult
  $Res call({String setName, String setCode, String setRarity});
}

/// @nodoc
class _$CardSetCopyWithImpl<$Res> implements $CardSetCopyWith<$Res> {
  _$CardSetCopyWithImpl(this._self, this._then);

  final CardSet _self;
  final $Res Function(CardSet) _then;

  /// Create a copy of CardSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setName = null,
    Object? setCode = null,
    Object? setRarity = null,
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
    ));
  }
}

/// Adds pattern-matching-related methods to [CardSet].
extension CardSetPatterns on CardSet {
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
    TResult Function(_CardSet value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardSet() when $default != null:
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
    TResult Function(_CardSet value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardSet():
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
    TResult? Function(_CardSet value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardSet() when $default != null:
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
    TResult Function(String setName, String setCode, String setRarity)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardSet() when $default != null:
        return $default(_that.setName, _that.setCode, _that.setRarity);
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
    TResult Function(String setName, String setCode, String setRarity) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardSet():
        return $default(_that.setName, _that.setCode, _that.setRarity);
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
    TResult? Function(String setName, String setCode, String setRarity)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardSet() when $default != null:
        return $default(_that.setName, _that.setCode, _that.setRarity);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CardSet implements CardSet {
  const _CardSet(
      {required this.setName, required this.setCode, required this.setRarity});
  factory _CardSet.fromJson(Map<String, dynamic> json) =>
      _$CardSetFromJson(json);

  @override
  final String setName;
  @override
  final String setCode;
  @override
  final String setRarity;

  /// Create a copy of CardSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CardSetCopyWith<_CardSet> get copyWith =>
      __$CardSetCopyWithImpl<_CardSet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardSetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CardSet &&
            (identical(other.setName, setName) || other.setName == setName) &&
            (identical(other.setCode, setCode) || other.setCode == setCode) &&
            (identical(other.setRarity, setRarity) ||
                other.setRarity == setRarity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, setName, setCode, setRarity);

  @override
  String toString() {
    return 'CardSet(setName: $setName, setCode: $setCode, setRarity: $setRarity)';
  }
}

/// @nodoc
abstract mixin class _$CardSetCopyWith<$Res> implements $CardSetCopyWith<$Res> {
  factory _$CardSetCopyWith(_CardSet value, $Res Function(_CardSet) _then) =
      __$CardSetCopyWithImpl;
  @override
  @useResult
  $Res call({String setName, String setCode, String setRarity});
}

/// @nodoc
class __$CardSetCopyWithImpl<$Res> implements _$CardSetCopyWith<$Res> {
  __$CardSetCopyWithImpl(this._self, this._then);

  final _CardSet _self;
  final $Res Function(_CardSet) _then;

  /// Create a copy of CardSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? setName = null,
    Object? setCode = null,
    Object? setRarity = null,
  }) {
    return _then(_CardSet(
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
    ));
  }
}

// dart format on
