// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sort_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SortState {
  SortOption get option;

  /// Create a copy of SortState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SortStateCopyWith<SortState> get copyWith =>
      _$SortStateCopyWithImpl<SortState>(this as SortState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SortState &&
            (identical(other.option, option) || other.option == option));
  }

  @override
  int get hashCode => Object.hash(runtimeType, option);

  @override
  String toString() {
    return 'SortState(option: $option)';
  }
}

/// @nodoc
abstract mixin class $SortStateCopyWith<$Res> {
  factory $SortStateCopyWith(SortState value, $Res Function(SortState) _then) =
      _$SortStateCopyWithImpl;
  @useResult
  $Res call({SortOption option});
}

/// @nodoc
class _$SortStateCopyWithImpl<$Res> implements $SortStateCopyWith<$Res> {
  _$SortStateCopyWithImpl(this._self, this._then);

  final SortState _self;
  final $Res Function(SortState) _then;

  /// Create a copy of SortState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? option = null,
  }) {
    return _then(_self.copyWith(
      option: null == option
          ? _self.option
          : option // ignore: cast_nullable_to_non_nullable
              as SortOption,
    ));
  }
}

/// Adds pattern-matching-related methods to [SortState].
extension SortStatePatterns on SortState {
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
    TResult Function(_SortState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SortState() when $default != null:
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
    TResult Function(_SortState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SortState():
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
    TResult? Function(_SortState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SortState() when $default != null:
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
    TResult Function(SortOption option)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SortState() when $default != null:
        return $default(_that.option);
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
    TResult Function(SortOption option) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SortState():
        return $default(_that.option);
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
    TResult? Function(SortOption option)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SortState() when $default != null:
        return $default(_that.option);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SortState implements SortState {
  const _SortState({required this.option});

  @override
  final SortOption option;

  /// Create a copy of SortState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SortStateCopyWith<_SortState> get copyWith =>
      __$SortStateCopyWithImpl<_SortState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SortState &&
            (identical(other.option, option) || other.option == option));
  }

  @override
  int get hashCode => Object.hash(runtimeType, option);

  @override
  String toString() {
    return 'SortState(option: $option)';
  }
}

/// @nodoc
abstract mixin class _$SortStateCopyWith<$Res>
    implements $SortStateCopyWith<$Res> {
  factory _$SortStateCopyWith(
          _SortState value, $Res Function(_SortState) _then) =
      __$SortStateCopyWithImpl;
  @override
  @useResult
  $Res call({SortOption option});
}

/// @nodoc
class __$SortStateCopyWithImpl<$Res> implements _$SortStateCopyWith<$Res> {
  __$SortStateCopyWithImpl(this._self, this._then);

  final _SortState _self;
  final $Res Function(_SortState) _then;

  /// Create a copy of SortState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? option = null,
  }) {
    return _then(_SortState(
      option: null == option
          ? _self.option
          : option // ignore: cast_nullable_to_non_nullable
              as SortOption,
    ));
  }
}

// dart format on
