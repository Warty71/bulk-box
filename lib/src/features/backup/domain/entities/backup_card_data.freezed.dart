// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_card_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupCardData {
  int get id;
  String get name;
  String get type;
  String get description;
  String get race;
  @JsonKey(name: 'frame_type')
  String? get frameType;
  String? get attribute;
  int? get level;
  int? get atk;
  int? get def;
  String? get archetype;
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @JsonKey(name: 'card_sets')
  List<BackupCardSetData> get cardSets;

  /// Create a copy of BackupCardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BackupCardDataCopyWith<BackupCardData> get copyWith =>
      _$BackupCardDataCopyWithImpl<BackupCardData>(
          this as BackupCardData, _$identity);

  /// Serializes this BackupCardData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BackupCardData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
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
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other.cardSets, cardSets));
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
      frameType,
      attribute,
      level,
      atk,
      def,
      archetype,
      imageUrl,
      const DeepCollectionEquality().hash(cardSets));

  @override
  String toString() {
    return 'BackupCardData(id: $id, name: $name, type: $type, description: $description, race: $race, frameType: $frameType, attribute: $attribute, level: $level, atk: $atk, def: $def, archetype: $archetype, imageUrl: $imageUrl, cardSets: $cardSets)';
  }
}

/// @nodoc
abstract mixin class $BackupCardDataCopyWith<$Res> {
  factory $BackupCardDataCopyWith(
          BackupCardData value, $Res Function(BackupCardData) _then) =
      _$BackupCardDataCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      String description,
      String race,
      @JsonKey(name: 'frame_type') String? frameType,
      String? attribute,
      int? level,
      int? atk,
      int? def,
      String? archetype,
      @JsonKey(name: 'image_url') String imageUrl,
      @JsonKey(name: 'card_sets') List<BackupCardSetData> cardSets});
}

/// @nodoc
class _$BackupCardDataCopyWithImpl<$Res>
    implements $BackupCardDataCopyWith<$Res> {
  _$BackupCardDataCopyWithImpl(this._self, this._then);

  final BackupCardData _self;
  final $Res Function(BackupCardData) _then;

  /// Create a copy of BackupCardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? description = null,
    Object? race = null,
    Object? frameType = freezed,
    Object? attribute = freezed,
    Object? level = freezed,
    Object? atk = freezed,
    Object? def = freezed,
    Object? archetype = freezed,
    Object? imageUrl = null,
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
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
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
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      cardSets: null == cardSets
          ? _self.cardSets
          : cardSets // ignore: cast_nullable_to_non_nullable
              as List<BackupCardSetData>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BackupCardData].
extension BackupCardDataPatterns on BackupCardData {
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
    TResult Function(_BackupCardData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BackupCardData() when $default != null:
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
    TResult Function(_BackupCardData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupCardData():
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
    TResult? Function(_BackupCardData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupCardData() when $default != null:
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
            @JsonKey(name: 'frame_type') String? frameType,
            String? attribute,
            int? level,
            int? atk,
            int? def,
            String? archetype,
            @JsonKey(name: 'image_url') String imageUrl,
            @JsonKey(name: 'card_sets') List<BackupCardSetData> cardSets)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BackupCardData() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.description,
            _that.race,
            _that.frameType,
            _that.attribute,
            _that.level,
            _that.atk,
            _that.def,
            _that.archetype,
            _that.imageUrl,
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
            String description,
            String race,
            @JsonKey(name: 'frame_type') String? frameType,
            String? attribute,
            int? level,
            int? atk,
            int? def,
            String? archetype,
            @JsonKey(name: 'image_url') String imageUrl,
            @JsonKey(name: 'card_sets') List<BackupCardSetData> cardSets)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupCardData():
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.description,
            _that.race,
            _that.frameType,
            _that.attribute,
            _that.level,
            _that.atk,
            _that.def,
            _that.archetype,
            _that.imageUrl,
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
            String description,
            String race,
            @JsonKey(name: 'frame_type') String? frameType,
            String? attribute,
            int? level,
            int? atk,
            int? def,
            String? archetype,
            @JsonKey(name: 'image_url') String imageUrl,
            @JsonKey(name: 'card_sets') List<BackupCardSetData> cardSets)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupCardData() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.description,
            _that.race,
            _that.frameType,
            _that.attribute,
            _that.level,
            _that.atk,
            _that.def,
            _that.archetype,
            _that.imageUrl,
            _that.cardSets);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BackupCardData extends BackupCardData {
  const _BackupCardData(
      {required this.id,
      required this.name,
      required this.type,
      required this.description,
      required this.race,
      @JsonKey(name: 'frame_type') this.frameType,
      this.attribute,
      this.level,
      this.atk,
      this.def,
      this.archetype,
      @JsonKey(name: 'image_url') required this.imageUrl,
      @JsonKey(name: 'card_sets')
      required final List<BackupCardSetData> cardSets})
      : _cardSets = cardSets,
        super._();
  factory _BackupCardData.fromJson(Map<String, dynamic> json) =>
      _$BackupCardDataFromJson(json);

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
  @JsonKey(name: 'frame_type')
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
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final List<BackupCardSetData> _cardSets;
  @override
  @JsonKey(name: 'card_sets')
  List<BackupCardSetData> get cardSets {
    if (_cardSets is EqualUnmodifiableListView) return _cardSets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cardSets);
  }

  /// Create a copy of BackupCardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BackupCardDataCopyWith<_BackupCardData> get copyWith =>
      __$BackupCardDataCopyWithImpl<_BackupCardData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BackupCardDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BackupCardData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
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
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._cardSets, _cardSets));
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
      frameType,
      attribute,
      level,
      atk,
      def,
      archetype,
      imageUrl,
      const DeepCollectionEquality().hash(_cardSets));

  @override
  String toString() {
    return 'BackupCardData(id: $id, name: $name, type: $type, description: $description, race: $race, frameType: $frameType, attribute: $attribute, level: $level, atk: $atk, def: $def, archetype: $archetype, imageUrl: $imageUrl, cardSets: $cardSets)';
  }
}

/// @nodoc
abstract mixin class _$BackupCardDataCopyWith<$Res>
    implements $BackupCardDataCopyWith<$Res> {
  factory _$BackupCardDataCopyWith(
          _BackupCardData value, $Res Function(_BackupCardData) _then) =
      __$BackupCardDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      String description,
      String race,
      @JsonKey(name: 'frame_type') String? frameType,
      String? attribute,
      int? level,
      int? atk,
      int? def,
      String? archetype,
      @JsonKey(name: 'image_url') String imageUrl,
      @JsonKey(name: 'card_sets') List<BackupCardSetData> cardSets});
}

/// @nodoc
class __$BackupCardDataCopyWithImpl<$Res>
    implements _$BackupCardDataCopyWith<$Res> {
  __$BackupCardDataCopyWithImpl(this._self, this._then);

  final _BackupCardData _self;
  final $Res Function(_BackupCardData) _then;

  /// Create a copy of BackupCardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? description = null,
    Object? race = null,
    Object? frameType = freezed,
    Object? attribute = freezed,
    Object? level = freezed,
    Object? atk = freezed,
    Object? def = freezed,
    Object? archetype = freezed,
    Object? imageUrl = null,
    Object? cardSets = null,
  }) {
    return _then(_BackupCardData(
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
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      cardSets: null == cardSets
          ? _self._cardSets
          : cardSets // ignore: cast_nullable_to_non_nullable
              as List<BackupCardSetData>,
    ));
  }
}

// dart format on
