// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_card_set_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupCardSetData {
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

  /// Create a copy of BackupCardSetData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BackupCardSetDataCopyWith<BackupCardSetData> get copyWith =>
      _$BackupCardSetDataCopyWithImpl<BackupCardSetData>(
          this as BackupCardSetData, _$identity);

  /// Serializes this BackupCardSetData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BackupCardSetData &&
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
    return 'BackupCardSetData(setName: $setName, setCode: $setCode, setRarity: $setRarity, setEdition: $setEdition, setPrice: $setPrice, setPriceLow: $setPriceLow, setUrl: $setUrl)';
  }
}

/// @nodoc
abstract mixin class $BackupCardSetDataCopyWith<$Res> {
  factory $BackupCardSetDataCopyWith(
          BackupCardSetData value, $Res Function(BackupCardSetData) _then) =
      _$BackupCardSetDataCopyWithImpl;
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
class _$BackupCardSetDataCopyWithImpl<$Res>
    implements $BackupCardSetDataCopyWith<$Res> {
  _$BackupCardSetDataCopyWithImpl(this._self, this._then);

  final BackupCardSetData _self;
  final $Res Function(BackupCardSetData) _then;

  /// Create a copy of BackupCardSetData
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

/// Adds pattern-matching-related methods to [BackupCardSetData].
extension BackupCardSetDataPatterns on BackupCardSetData {
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
    TResult Function(_BackupCardSetData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BackupCardSetData() when $default != null:
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
    TResult Function(_BackupCardSetData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupCardSetData():
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
    TResult? Function(_BackupCardSetData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackupCardSetData() when $default != null:
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
      case _BackupCardSetData() when $default != null:
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
      case _BackupCardSetData():
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
      case _BackupCardSetData() when $default != null:
        return $default(_that.setName, _that.setCode, _that.setRarity,
            _that.setEdition, _that.setPrice, _that.setPriceLow, _that.setUrl);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BackupCardSetData implements BackupCardSetData {
  const _BackupCardSetData(
      {@JsonKey(name: 'set_name') required this.setName,
      @JsonKey(name: 'set_code') required this.setCode,
      @JsonKey(name: 'set_rarity') required this.setRarity,
      @JsonKey(name: 'set_edition') this.setEdition,
      @JsonKey(name: 'set_price') this.setPrice,
      @JsonKey(name: 'set_price_low') this.setPriceLow,
      @JsonKey(name: 'set_url') this.setUrl});
  factory _BackupCardSetData.fromJson(Map<String, dynamic> json) =>
      _$BackupCardSetDataFromJson(json);

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

  /// Create a copy of BackupCardSetData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BackupCardSetDataCopyWith<_BackupCardSetData> get copyWith =>
      __$BackupCardSetDataCopyWithImpl<_BackupCardSetData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BackupCardSetDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BackupCardSetData &&
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
    return 'BackupCardSetData(setName: $setName, setCode: $setCode, setRarity: $setRarity, setEdition: $setEdition, setPrice: $setPrice, setPriceLow: $setPriceLow, setUrl: $setUrl)';
  }
}

/// @nodoc
abstract mixin class _$BackupCardSetDataCopyWith<$Res>
    implements $BackupCardSetDataCopyWith<$Res> {
  factory _$BackupCardSetDataCopyWith(
          _BackupCardSetData value, $Res Function(_BackupCardSetData) _then) =
      __$BackupCardSetDataCopyWithImpl;
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
class __$BackupCardSetDataCopyWithImpl<$Res>
    implements _$BackupCardSetDataCopyWith<$Res> {
  __$BackupCardSetDataCopyWithImpl(this._self, this._then);

  final _BackupCardSetData _self;
  final $Res Function(_BackupCardSetData) _then;

  /// Create a copy of BackupCardSetData
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
    return _then(_BackupCardSetData(
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
