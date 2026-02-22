// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupManifest {
  int get version;
  @JsonKey(name: 'schema_version')
  int get schemaVersion;
  @JsonKey(name: 'exported_at')
  DateTime get exportedAt;
  List<BackupCardData> get cards;
  List<BackupBoxData> get boxes;
  @JsonKey(name: 'unboxed_items')
  List<BackupItemData> get unboxedItems;

  /// Create a copy of BackupManifest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BackupManifestCopyWith<BackupManifest> get copyWith =>
      _$BackupManifestCopyWithImpl<BackupManifest>(
          this as BackupManifest, _$identity);

  /// Serializes this BackupManifest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BackupManifest &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.schemaVersion, schemaVersion) ||
                other.schemaVersion == schemaVersion) &&
            (identical(other.exportedAt, exportedAt) ||
                other.exportedAt == exportedAt) &&
            const DeepCollectionEquality().equals(other.cards, cards) &&
            const DeepCollectionEquality().equals(other.boxes, boxes) &&
            const DeepCollectionEquality()
                .equals(other.unboxedItems, unboxedItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      version,
      schemaVersion,
      exportedAt,
      const DeepCollectionEquality().hash(cards),
      const DeepCollectionEquality().hash(boxes),
      const DeepCollectionEquality().hash(unboxedItems));

  @override
  String toString() {
    return 'BackupManifest(version: $version, schemaVersion: $schemaVersion, exportedAt: $exportedAt, cards: $cards, boxes: $boxes, unboxedItems: $unboxedItems)';
  }
}

/// @nodoc
abstract mixin class $BackupManifestCopyWith<$Res> {
  factory $BackupManifestCopyWith(
          BackupManifest value, $Res Function(BackupManifest) _then) =
      _$BackupManifestCopyWithImpl;
  @useResult
  $Res call(
      {int version,
      @JsonKey(name: 'schema_version') int schemaVersion,
      @JsonKey(name: 'exported_at') DateTime exportedAt,
      List<BackupCardData> cards,
      List<BackupBoxData> boxes,
      @JsonKey(name: 'unboxed_items') List<BackupItemData> unboxedItems});
}

/// @nodoc
class _$BackupManifestCopyWithImpl<$Res>
    implements $BackupManifestCopyWith<$Res> {
  _$BackupManifestCopyWithImpl(this._self, this._then);

  final BackupManifest _self;
  final $Res Function(BackupManifest) _then;

  /// Create a copy of BackupManifest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? schemaVersion = null,
    Object? exportedAt = null,
    Object? cards = null,
    Object? boxes = null,
    Object? unboxedItems = null,
  }) {
    return _then(_self.copyWith(
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      schemaVersion: null == schemaVersion
          ? _self.schemaVersion
          : schemaVersion // ignore: cast_nullable_to_non_nullable
              as int,
      exportedAt: null == exportedAt
          ? _self.exportedAt
          : exportedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cards: null == cards
          ? _self.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<BackupCardData>,
      boxes: null == boxes
          ? _self.boxes
          : boxes // ignore: cast_nullable_to_non_nullable
              as List<BackupBoxData>,
      unboxedItems: null == unboxedItems
          ? _self.unboxedItems
          : unboxedItems // ignore: cast_nullable_to_non_nullable
              as List<BackupItemData>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BackupManifest].
extension BackupManifestPatterns on BackupManifest {
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
    TResult Function(_BackupManifest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BackupManifest() when $default != null:
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
    TResult Function(_BackupManifest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupManifest():
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
    TResult? Function(_BackupManifest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupManifest() when $default != null:
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
            int version,
            @JsonKey(name: 'schema_version') int schemaVersion,
            @JsonKey(name: 'exported_at') DateTime exportedAt,
            List<BackupCardData> cards,
            List<BackupBoxData> boxes,
            @JsonKey(name: 'unboxed_items') List<BackupItemData> unboxedItems)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BackupManifest() when $default != null:
        return $default(_that.version, _that.schemaVersion, _that.exportedAt,
            _that.cards, _that.boxes, _that.unboxedItems);
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
            int version,
            @JsonKey(name: 'schema_version') int schemaVersion,
            @JsonKey(name: 'exported_at') DateTime exportedAt,
            List<BackupCardData> cards,
            List<BackupBoxData> boxes,
            @JsonKey(name: 'unboxed_items') List<BackupItemData> unboxedItems)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupManifest():
        return $default(_that.version, _that.schemaVersion, _that.exportedAt,
            _that.cards, _that.boxes, _that.unboxedItems);
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
            int version,
            @JsonKey(name: 'schema_version') int schemaVersion,
            @JsonKey(name: 'exported_at') DateTime exportedAt,
            List<BackupCardData> cards,
            List<BackupBoxData> boxes,
            @JsonKey(name: 'unboxed_items') List<BackupItemData> unboxedItems)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupManifest() when $default != null:
        return $default(_that.version, _that.schemaVersion, _that.exportedAt,
            _that.cards, _that.boxes, _that.unboxedItems);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BackupManifest implements BackupManifest {
  const _BackupManifest(
      {required this.version,
      @JsonKey(name: 'schema_version') required this.schemaVersion,
      @JsonKey(name: 'exported_at') required this.exportedAt,
      required final List<BackupCardData> cards,
      required final List<BackupBoxData> boxes,
      @JsonKey(name: 'unboxed_items')
      required final List<BackupItemData> unboxedItems})
      : _cards = cards,
        _boxes = boxes,
        _unboxedItems = unboxedItems;
  factory _BackupManifest.fromJson(Map<String, dynamic> json) =>
      _$BackupManifestFromJson(json);

  @override
  final int version;
  @override
  @JsonKey(name: 'schema_version')
  final int schemaVersion;
  @override
  @JsonKey(name: 'exported_at')
  final DateTime exportedAt;
  final List<BackupCardData> _cards;
  @override
  List<BackupCardData> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  final List<BackupBoxData> _boxes;
  @override
  List<BackupBoxData> get boxes {
    if (_boxes is EqualUnmodifiableListView) return _boxes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_boxes);
  }

  final List<BackupItemData> _unboxedItems;
  @override
  @JsonKey(name: 'unboxed_items')
  List<BackupItemData> get unboxedItems {
    if (_unboxedItems is EqualUnmodifiableListView) return _unboxedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unboxedItems);
  }

  /// Create a copy of BackupManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BackupManifestCopyWith<_BackupManifest> get copyWith =>
      __$BackupManifestCopyWithImpl<_BackupManifest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BackupManifestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BackupManifest &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.schemaVersion, schemaVersion) ||
                other.schemaVersion == schemaVersion) &&
            (identical(other.exportedAt, exportedAt) ||
                other.exportedAt == exportedAt) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            const DeepCollectionEquality().equals(other._boxes, _boxes) &&
            const DeepCollectionEquality()
                .equals(other._unboxedItems, _unboxedItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      version,
      schemaVersion,
      exportedAt,
      const DeepCollectionEquality().hash(_cards),
      const DeepCollectionEquality().hash(_boxes),
      const DeepCollectionEquality().hash(_unboxedItems));

  @override
  String toString() {
    return 'BackupManifest(version: $version, schemaVersion: $schemaVersion, exportedAt: $exportedAt, cards: $cards, boxes: $boxes, unboxedItems: $unboxedItems)';
  }
}

/// @nodoc
abstract mixin class _$BackupManifestCopyWith<$Res>
    implements $BackupManifestCopyWith<$Res> {
  factory _$BackupManifestCopyWith(
          _BackupManifest value, $Res Function(_BackupManifest) _then) =
      __$BackupManifestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int version,
      @JsonKey(name: 'schema_version') int schemaVersion,
      @JsonKey(name: 'exported_at') DateTime exportedAt,
      List<BackupCardData> cards,
      List<BackupBoxData> boxes,
      @JsonKey(name: 'unboxed_items') List<BackupItemData> unboxedItems});
}

/// @nodoc
class __$BackupManifestCopyWithImpl<$Res>
    implements _$BackupManifestCopyWith<$Res> {
  __$BackupManifestCopyWithImpl(this._self, this._then);

  final _BackupManifest _self;
  final $Res Function(_BackupManifest) _then;

  /// Create a copy of BackupManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? version = null,
    Object? schemaVersion = null,
    Object? exportedAt = null,
    Object? cards = null,
    Object? boxes = null,
    Object? unboxedItems = null,
  }) {
    return _then(_BackupManifest(
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      schemaVersion: null == schemaVersion
          ? _self.schemaVersion
          : schemaVersion // ignore: cast_nullable_to_non_nullable
              as int,
      exportedAt: null == exportedAt
          ? _self.exportedAt
          : exportedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cards: null == cards
          ? _self._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<BackupCardData>,
      boxes: null == boxes
          ? _self._boxes
          : boxes // ignore: cast_nullable_to_non_nullable
              as List<BackupBoxData>,
      unboxedItems: null == unboxedItems
          ? _self._unboxedItems
          : unboxedItems // ignore: cast_nullable_to_non_nullable
              as List<BackupItemData>,
    ));
  }
}

// dart format on
