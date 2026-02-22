// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_item_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupItemData {
  @JsonKey(name: 'card_id')
  int get cardId;
  @JsonKey(name: 'set_code')
  String get setCode;
  @JsonKey(name: 'set_rarity')
  String get setRarity;
  int get quantity;
  String? get condition;
  @JsonKey(name: 'date_added')
  DateTime get dateAdded;

  /// Create a copy of BackupItemData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BackupItemDataCopyWith<BackupItemData> get copyWith =>
      _$BackupItemDataCopyWithImpl<BackupItemData>(
          this as BackupItemData, _$identity);

  /// Serializes this BackupItemData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BackupItemData &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.setCode, setCode) || other.setCode == setCode) &&
            (identical(other.setRarity, setRarity) ||
                other.setRarity == setRarity) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.dateAdded, dateAdded) ||
                other.dateAdded == dateAdded));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, cardId, setCode, setRarity, quantity, condition, dateAdded);

  @override
  String toString() {
    return 'BackupItemData(cardId: $cardId, setCode: $setCode, setRarity: $setRarity, quantity: $quantity, condition: $condition, dateAdded: $dateAdded)';
  }
}

/// @nodoc
abstract mixin class $BackupItemDataCopyWith<$Res> {
  factory $BackupItemDataCopyWith(
          BackupItemData value, $Res Function(BackupItemData) _then) =
      _$BackupItemDataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'card_id') int cardId,
      @JsonKey(name: 'set_code') String setCode,
      @JsonKey(name: 'set_rarity') String setRarity,
      int quantity,
      String? condition,
      @JsonKey(name: 'date_added') DateTime dateAdded});
}

/// @nodoc
class _$BackupItemDataCopyWithImpl<$Res>
    implements $BackupItemDataCopyWith<$Res> {
  _$BackupItemDataCopyWithImpl(this._self, this._then);

  final BackupItemData _self;
  final $Res Function(BackupItemData) _then;

  /// Create a copy of BackupItemData
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
    ));
  }
}

/// Adds pattern-matching-related methods to [BackupItemData].
extension BackupItemDataPatterns on BackupItemData {
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
    TResult Function(_BackupItemData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BackupItemData() when $default != null:
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
    TResult Function(_BackupItemData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupItemData():
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
    TResult? Function(_BackupItemData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupItemData() when $default != null:
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
            @JsonKey(name: 'card_id') int cardId,
            @JsonKey(name: 'set_code') String setCode,
            @JsonKey(name: 'set_rarity') String setRarity,
            int quantity,
            String? condition,
            @JsonKey(name: 'date_added') DateTime dateAdded)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BackupItemData() when $default != null:
        return $default(_that.cardId, _that.setCode, _that.setRarity,
            _that.quantity, _that.condition, _that.dateAdded);
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
            @JsonKey(name: 'card_id') int cardId,
            @JsonKey(name: 'set_code') String setCode,
            @JsonKey(name: 'set_rarity') String setRarity,
            int quantity,
            String? condition,
            @JsonKey(name: 'date_added') DateTime dateAdded)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupItemData():
        return $default(_that.cardId, _that.setCode, _that.setRarity,
            _that.quantity, _that.condition, _that.dateAdded);
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
            @JsonKey(name: 'card_id') int cardId,
            @JsonKey(name: 'set_code') String setCode,
            @JsonKey(name: 'set_rarity') String setRarity,
            int quantity,
            String? condition,
            @JsonKey(name: 'date_added') DateTime dateAdded)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupItemData() when $default != null:
        return $default(_that.cardId, _that.setCode, _that.setRarity,
            _that.quantity, _that.condition, _that.dateAdded);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BackupItemData implements BackupItemData {
  const _BackupItemData(
      {@JsonKey(name: 'card_id') required this.cardId,
      @JsonKey(name: 'set_code') required this.setCode,
      @JsonKey(name: 'set_rarity') required this.setRarity,
      required this.quantity,
      this.condition,
      @JsonKey(name: 'date_added') required this.dateAdded});
  factory _BackupItemData.fromJson(Map<String, dynamic> json) =>
      _$BackupItemDataFromJson(json);

  @override
  @JsonKey(name: 'card_id')
  final int cardId;
  @override
  @JsonKey(name: 'set_code')
  final String setCode;
  @override
  @JsonKey(name: 'set_rarity')
  final String setRarity;
  @override
  final int quantity;
  @override
  final String? condition;
  @override
  @JsonKey(name: 'date_added')
  final DateTime dateAdded;

  /// Create a copy of BackupItemData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BackupItemDataCopyWith<_BackupItemData> get copyWith =>
      __$BackupItemDataCopyWithImpl<_BackupItemData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BackupItemDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BackupItemData &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.setCode, setCode) || other.setCode == setCode) &&
            (identical(other.setRarity, setRarity) ||
                other.setRarity == setRarity) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.dateAdded, dateAdded) ||
                other.dateAdded == dateAdded));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, cardId, setCode, setRarity, quantity, condition, dateAdded);

  @override
  String toString() {
    return 'BackupItemData(cardId: $cardId, setCode: $setCode, setRarity: $setRarity, quantity: $quantity, condition: $condition, dateAdded: $dateAdded)';
  }
}

/// @nodoc
abstract mixin class _$BackupItemDataCopyWith<$Res>
    implements $BackupItemDataCopyWith<$Res> {
  factory _$BackupItemDataCopyWith(
          _BackupItemData value, $Res Function(_BackupItemData) _then) =
      __$BackupItemDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'card_id') int cardId,
      @JsonKey(name: 'set_code') String setCode,
      @JsonKey(name: 'set_rarity') String setRarity,
      int quantity,
      String? condition,
      @JsonKey(name: 'date_added') DateTime dateAdded});
}

/// @nodoc
class __$BackupItemDataCopyWithImpl<$Res>
    implements _$BackupItemDataCopyWith<$Res> {
  __$BackupItemDataCopyWithImpl(this._self, this._then);

  final _BackupItemData _self;
  final $Res Function(_BackupItemData) _then;

  /// Create a copy of BackupItemData
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
  }) {
    return _then(_BackupItemData(
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
    ));
  }
}

// dart format on
