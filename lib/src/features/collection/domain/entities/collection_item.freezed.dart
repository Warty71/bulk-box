// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CollectionItemEntity {
  int get cardId;
  String get setCode;
  String get setRarity;
  int get quantity;
  String? get condition;
  DateTime get dateAdded;

  /// Box this item is in; null means unboxed.
  int? get boxId;

  /// Create a copy of CollectionItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CollectionItemEntityCopyWith<CollectionItemEntity> get copyWith =>
      _$CollectionItemEntityCopyWithImpl<CollectionItemEntity>(
          this as CollectionItemEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CollectionItemEntity &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.setCode, setCode) || other.setCode == setCode) &&
            (identical(other.setRarity, setRarity) ||
                other.setRarity == setRarity) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.dateAdded, dateAdded) ||
                other.dateAdded == dateAdded) &&
            (identical(other.boxId, boxId) || other.boxId == boxId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cardId, setCode, setRarity,
      quantity, condition, dateAdded, boxId);

  @override
  String toString() {
    return 'CollectionItemEntity(cardId: $cardId, setCode: $setCode, setRarity: $setRarity, quantity: $quantity, condition: $condition, dateAdded: $dateAdded, boxId: $boxId)';
  }
}

/// @nodoc
abstract mixin class $CollectionItemEntityCopyWith<$Res> {
  factory $CollectionItemEntityCopyWith(CollectionItemEntity value,
          $Res Function(CollectionItemEntity) _then) =
      _$CollectionItemEntityCopyWithImpl;
  @useResult
  $Res call(
      {int cardId,
      String setCode,
      String setRarity,
      int quantity,
      String? condition,
      DateTime dateAdded,
      int? boxId});
}

/// @nodoc
class _$CollectionItemEntityCopyWithImpl<$Res>
    implements $CollectionItemEntityCopyWith<$Res> {
  _$CollectionItemEntityCopyWithImpl(this._self, this._then);

  final CollectionItemEntity _self;
  final $Res Function(CollectionItemEntity) _then;

  /// Create a copy of CollectionItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
    Object? setCode = null,
    Object? setRarity = null,
    Object? quantity = null,
    Object? condition = freezed,
    Object? dateAdded = null,
    Object? boxId = freezed,
  }) {
    return _then(_self.copyWith(
      cardId: null == cardId
          ? _self.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as int,
      setCode: null == setCode
          ? _self.setCode
          : setCode // ignore: cast_nullable_to_non_nullable
              as String,
      setRarity: null == setRarity
          ? _self.setRarity
          : setRarity // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      condition: freezed == condition
          ? _self.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String?,
      dateAdded: null == dateAdded
          ? _self.dateAdded
          : dateAdded // ignore: cast_nullable_to_non_nullable
              as DateTime,
      boxId: freezed == boxId
          ? _self.boxId
          : boxId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CollectionItemEntity].
extension CollectionItemEntityPatterns on CollectionItemEntity {
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
    TResult Function(_CollectionItemEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CollectionItemEntity() when $default != null:
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
    TResult Function(_CollectionItemEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CollectionItemEntity():
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
    TResult? Function(_CollectionItemEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CollectionItemEntity() when $default != null:
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
    TResult Function(int cardId, String setCode, String setRarity, int quantity,
            String? condition, DateTime dateAdded, int? boxId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CollectionItemEntity() when $default != null:
        return $default(_that.cardId, _that.setCode, _that.setRarity,
            _that.quantity, _that.condition, _that.dateAdded, _that.boxId);
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
    TResult Function(int cardId, String setCode, String setRarity, int quantity,
            String? condition, DateTime dateAdded, int? boxId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CollectionItemEntity():
        return $default(_that.cardId, _that.setCode, _that.setRarity,
            _that.quantity, _that.condition, _that.dateAdded, _that.boxId);
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
    TResult? Function(int cardId, String setCode, String setRarity,
            int quantity, String? condition, DateTime dateAdded, int? boxId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CollectionItemEntity() when $default != null:
        return $default(_that.cardId, _that.setCode, _that.setRarity,
            _that.quantity, _that.condition, _that.dateAdded, _that.boxId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CollectionItemEntity implements CollectionItemEntity {
  const _CollectionItemEntity(
      {required this.cardId,
      required this.setCode,
      required this.setRarity,
      required this.quantity,
      this.condition,
      required this.dateAdded,
      this.boxId});

  @override
  final int cardId;
  @override
  final String setCode;
  @override
  final String setRarity;
  @override
  final int quantity;
  @override
  final String? condition;
  @override
  final DateTime dateAdded;

  /// Box this item is in; null means unboxed.
  @override
  final int? boxId;

  /// Create a copy of CollectionItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CollectionItemEntityCopyWith<_CollectionItemEntity> get copyWith =>
      __$CollectionItemEntityCopyWithImpl<_CollectionItemEntity>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CollectionItemEntity &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.setCode, setCode) || other.setCode == setCode) &&
            (identical(other.setRarity, setRarity) ||
                other.setRarity == setRarity) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.dateAdded, dateAdded) ||
                other.dateAdded == dateAdded) &&
            (identical(other.boxId, boxId) || other.boxId == boxId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cardId, setCode, setRarity,
      quantity, condition, dateAdded, boxId);

  @override
  String toString() {
    return 'CollectionItemEntity(cardId: $cardId, setCode: $setCode, setRarity: $setRarity, quantity: $quantity, condition: $condition, dateAdded: $dateAdded, boxId: $boxId)';
  }
}

/// @nodoc
abstract mixin class _$CollectionItemEntityCopyWith<$Res>
    implements $CollectionItemEntityCopyWith<$Res> {
  factory _$CollectionItemEntityCopyWith(_CollectionItemEntity value,
          $Res Function(_CollectionItemEntity) _then) =
      __$CollectionItemEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int cardId,
      String setCode,
      String setRarity,
      int quantity,
      String? condition,
      DateTime dateAdded,
      int? boxId});
}

/// @nodoc
class __$CollectionItemEntityCopyWithImpl<$Res>
    implements _$CollectionItemEntityCopyWith<$Res> {
  __$CollectionItemEntityCopyWithImpl(this._self, this._then);

  final _CollectionItemEntity _self;
  final $Res Function(_CollectionItemEntity) _then;

  /// Create a copy of CollectionItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cardId = null,
    Object? setCode = null,
    Object? setRarity = null,
    Object? quantity = null,
    Object? condition = freezed,
    Object? dateAdded = null,
    Object? boxId = freezed,
  }) {
    return _then(_CollectionItemEntity(
      cardId: null == cardId
          ? _self.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as int,
      setCode: null == setCode
          ? _self.setCode
          : setCode // ignore: cast_nullable_to_non_nullable
              as String,
      setRarity: null == setRarity
          ? _self.setRarity
          : setRarity // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      condition: freezed == condition
          ? _self.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String?,
      dateAdded: null == dateAdded
          ? _self.dateAdded
          : dateAdded // ignore: cast_nullable_to_non_nullable
              as DateTime,
      boxId: freezed == boxId
          ? _self.boxId
          : boxId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
