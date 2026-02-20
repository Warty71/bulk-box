// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bulk_move_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BulkMoveState {
  bool get isSelectionMode;
  Set<String> get selectedKeys;

  /// Create a copy of BulkMoveState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BulkMoveStateCopyWith<BulkMoveState> get copyWith =>
      _$BulkMoveStateCopyWithImpl<BulkMoveState>(
          this as BulkMoveState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BulkMoveState &&
            (identical(other.isSelectionMode, isSelectionMode) ||
                other.isSelectionMode == isSelectionMode) &&
            const DeepCollectionEquality()
                .equals(other.selectedKeys, selectedKeys));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isSelectionMode,
      const DeepCollectionEquality().hash(selectedKeys));

  @override
  String toString() {
    return 'BulkMoveState(isSelectionMode: $isSelectionMode, selectedKeys: $selectedKeys)';
  }
}

/// @nodoc
abstract mixin class $BulkMoveStateCopyWith<$Res> {
  factory $BulkMoveStateCopyWith(
          BulkMoveState value, $Res Function(BulkMoveState) _then) =
      _$BulkMoveStateCopyWithImpl;
  @useResult
  $Res call({bool isSelectionMode, Set<String> selectedKeys});
}

/// @nodoc
class _$BulkMoveStateCopyWithImpl<$Res>
    implements $BulkMoveStateCopyWith<$Res> {
  _$BulkMoveStateCopyWithImpl(this._self, this._then);

  final BulkMoveState _self;
  final $Res Function(BulkMoveState) _then;

  /// Create a copy of BulkMoveState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSelectionMode = null,
    Object? selectedKeys = null,
  }) {
    return _then(_self.copyWith(
      isSelectionMode: null == isSelectionMode
          ? _self.isSelectionMode
          : isSelectionMode // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedKeys: null == selectedKeys
          ? _self.selectedKeys
          : selectedKeys // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BulkMoveState].
extension BulkMoveStatePatterns on BulkMoveState {
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
    TResult Function(_BulkMoveState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkMoveState() when $default != null:
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
    TResult Function(_BulkMoveState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkMoveState():
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
    TResult? Function(_BulkMoveState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkMoveState() when $default != null:
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
    TResult Function(bool isSelectionMode, Set<String> selectedKeys)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkMoveState() when $default != null:
        return $default(_that.isSelectionMode, _that.selectedKeys);
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
    TResult Function(bool isSelectionMode, Set<String> selectedKeys) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkMoveState():
        return $default(_that.isSelectionMode, _that.selectedKeys);
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
    TResult? Function(bool isSelectionMode, Set<String> selectedKeys)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkMoveState() when $default != null:
        return $default(_that.isSelectionMode, _that.selectedKeys);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BulkMoveState extends BulkMoveState {
  const _BulkMoveState(
      {this.isSelectionMode = false,
      final Set<String> selectedKeys = const <String>{}})
      : _selectedKeys = selectedKeys,
        super._();

  @override
  @JsonKey()
  final bool isSelectionMode;
  final Set<String> _selectedKeys;
  @override
  @JsonKey()
  Set<String> get selectedKeys {
    if (_selectedKeys is EqualUnmodifiableSetView) return _selectedKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedKeys);
  }

  /// Create a copy of BulkMoveState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BulkMoveStateCopyWith<_BulkMoveState> get copyWith =>
      __$BulkMoveStateCopyWithImpl<_BulkMoveState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BulkMoveState &&
            (identical(other.isSelectionMode, isSelectionMode) ||
                other.isSelectionMode == isSelectionMode) &&
            const DeepCollectionEquality()
                .equals(other._selectedKeys, _selectedKeys));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isSelectionMode,
      const DeepCollectionEquality().hash(_selectedKeys));

  @override
  String toString() {
    return 'BulkMoveState(isSelectionMode: $isSelectionMode, selectedKeys: $selectedKeys)';
  }
}

/// @nodoc
abstract mixin class _$BulkMoveStateCopyWith<$Res>
    implements $BulkMoveStateCopyWith<$Res> {
  factory _$BulkMoveStateCopyWith(
          _BulkMoveState value, $Res Function(_BulkMoveState) _then) =
      __$BulkMoveStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool isSelectionMode, Set<String> selectedKeys});
}

/// @nodoc
class __$BulkMoveStateCopyWithImpl<$Res>
    implements _$BulkMoveStateCopyWith<$Res> {
  __$BulkMoveStateCopyWithImpl(this._self, this._then);

  final _BulkMoveState _self;
  final $Res Function(_BulkMoveState) _then;

  /// Create a copy of BulkMoveState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isSelectionMode = null,
    Object? selectedKeys = null,
  }) {
    return _then(_BulkMoveState(
      isSelectionMode: null == isSelectionMode
          ? _self.isSelectionMode
          : isSelectionMode // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedKeys: null == selectedKeys
          ? _self._selectedKeys
          : selectedKeys // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

// dart format on
