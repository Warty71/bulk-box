// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SetInfoModel {
  @JsonKey(name: 'set_name')
  String get setName;
  @JsonKey(name: 'set_code')
  String get setCode;
  @JsonKey(name: 'num_of_cards')
  int get numOfCards;
  @JsonKey(name: 'tcg_date')
  String get tcgDate;
  @JsonKey(name: 'set_image')
  String? get setImage;

  /// Create a copy of SetInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SetInfoModelCopyWith<SetInfoModel> get copyWith =>
      _$SetInfoModelCopyWithImpl<SetInfoModel>(
          this as SetInfoModel, _$identity);

  /// Serializes this SetInfoModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SetInfoModel &&
            (identical(other.setName, setName) || other.setName == setName) &&
            (identical(other.setCode, setCode) || other.setCode == setCode) &&
            (identical(other.numOfCards, numOfCards) ||
                other.numOfCards == numOfCards) &&
            (identical(other.tcgDate, tcgDate) || other.tcgDate == tcgDate) &&
            (identical(other.setImage, setImage) ||
                other.setImage == setImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, setName, setCode, numOfCards, tcgDate, setImage);

  @override
  String toString() {
    return 'SetInfoModel(setName: $setName, setCode: $setCode, numOfCards: $numOfCards, tcgDate: $tcgDate, setImage: $setImage)';
  }
}

/// @nodoc
abstract mixin class $SetInfoModelCopyWith<$Res> {
  factory $SetInfoModelCopyWith(
          SetInfoModel value, $Res Function(SetInfoModel) _then) =
      _$SetInfoModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'set_name') String setName,
      @JsonKey(name: 'set_code') String setCode,
      @JsonKey(name: 'num_of_cards') int numOfCards,
      @JsonKey(name: 'tcg_date') String tcgDate,
      @JsonKey(name: 'set_image') String? setImage});
}

/// @nodoc
class _$SetInfoModelCopyWithImpl<$Res> implements $SetInfoModelCopyWith<$Res> {
  _$SetInfoModelCopyWithImpl(this._self, this._then);

  final SetInfoModel _self;
  final $Res Function(SetInfoModel) _then;

  /// Create a copy of SetInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setName = null,
    Object? setCode = null,
    Object? numOfCards = null,
    Object? tcgDate = null,
    Object? setImage = freezed,
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
      numOfCards: null == numOfCards
          ? _self.numOfCards
          : numOfCards // ignore: cast_nullable_to_non_nullable
              as int,
      tcgDate: null == tcgDate
          ? _self.tcgDate
          : tcgDate // ignore: cast_nullable_to_non_nullable
              as String,
      setImage: freezed == setImage
          ? _self.setImage
          : setImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SetInfoModel].
extension SetInfoModelPatterns on SetInfoModel {
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
    TResult Function(_SetInfoModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SetInfoModel() when $default != null:
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
    TResult Function(_SetInfoModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SetInfoModel():
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
    TResult? Function(_SetInfoModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SetInfoModel() when $default != null:
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
            @JsonKey(name: 'num_of_cards') int numOfCards,
            @JsonKey(name: 'tcg_date') String tcgDate,
            @JsonKey(name: 'set_image') String? setImage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SetInfoModel() when $default != null:
        return $default(_that.setName, _that.setCode, _that.numOfCards,
            _that.tcgDate, _that.setImage);
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
            @JsonKey(name: 'num_of_cards') int numOfCards,
            @JsonKey(name: 'tcg_date') String tcgDate,
            @JsonKey(name: 'set_image') String? setImage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SetInfoModel():
        return $default(_that.setName, _that.setCode, _that.numOfCards,
            _that.tcgDate, _that.setImage);
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
            @JsonKey(name: 'num_of_cards') int numOfCards,
            @JsonKey(name: 'tcg_date') String tcgDate,
            @JsonKey(name: 'set_image') String? setImage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SetInfoModel() when $default != null:
        return $default(_that.setName, _that.setCode, _that.numOfCards,
            _that.tcgDate, _that.setImage);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SetInfoModel extends SetInfoModel {
  const _SetInfoModel(
      {@JsonKey(name: 'set_name') required this.setName,
      @JsonKey(name: 'set_code') required this.setCode,
      @JsonKey(name: 'num_of_cards') required this.numOfCards,
      @JsonKey(name: 'tcg_date') required this.tcgDate,
      @JsonKey(name: 'set_image') this.setImage})
      : super._();
  factory _SetInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SetInfoModelFromJson(json);

  @override
  @JsonKey(name: 'set_name')
  final String setName;
  @override
  @JsonKey(name: 'set_code')
  final String setCode;
  @override
  @JsonKey(name: 'num_of_cards')
  final int numOfCards;
  @override
  @JsonKey(name: 'tcg_date')
  final String tcgDate;
  @override
  @JsonKey(name: 'set_image')
  final String? setImage;

  /// Create a copy of SetInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SetInfoModelCopyWith<_SetInfoModel> get copyWith =>
      __$SetInfoModelCopyWithImpl<_SetInfoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SetInfoModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SetInfoModel &&
            (identical(other.setName, setName) || other.setName == setName) &&
            (identical(other.setCode, setCode) || other.setCode == setCode) &&
            (identical(other.numOfCards, numOfCards) ||
                other.numOfCards == numOfCards) &&
            (identical(other.tcgDate, tcgDate) || other.tcgDate == tcgDate) &&
            (identical(other.setImage, setImage) ||
                other.setImage == setImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, setName, setCode, numOfCards, tcgDate, setImage);

  @override
  String toString() {
    return 'SetInfoModel(setName: $setName, setCode: $setCode, numOfCards: $numOfCards, tcgDate: $tcgDate, setImage: $setImage)';
  }
}

/// @nodoc
abstract mixin class _$SetInfoModelCopyWith<$Res>
    implements $SetInfoModelCopyWith<$Res> {
  factory _$SetInfoModelCopyWith(
          _SetInfoModel value, $Res Function(_SetInfoModel) _then) =
      __$SetInfoModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'set_name') String setName,
      @JsonKey(name: 'set_code') String setCode,
      @JsonKey(name: 'num_of_cards') int numOfCards,
      @JsonKey(name: 'tcg_date') String tcgDate,
      @JsonKey(name: 'set_image') String? setImage});
}

/// @nodoc
class __$SetInfoModelCopyWithImpl<$Res>
    implements _$SetInfoModelCopyWith<$Res> {
  __$SetInfoModelCopyWithImpl(this._self, this._then);

  final _SetInfoModel _self;
  final $Res Function(_SetInfoModel) _then;

  /// Create a copy of SetInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? setName = null,
    Object? setCode = null,
    Object? numOfCards = null,
    Object? tcgDate = null,
    Object? setImage = freezed,
  }) {
    return _then(_SetInfoModel(
      setName: null == setName
          ? _self.setName
          : setName // ignore: cast_nullable_to_non_nullable
              as String,
      setCode: null == setCode
          ? _self.setCode
          : setCode // ignore: cast_nullable_to_non_nullable
              as String,
      numOfCards: null == numOfCards
          ? _self.numOfCards
          : numOfCards // ignore: cast_nullable_to_non_nullable
              as int,
      tcgDate: null == tcgDate
          ? _self.tcgDate
          : tcgDate // ignore: cast_nullable_to_non_nullable
              as String,
      setImage: freezed == setImage
          ? _self.setImage
          : setImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
