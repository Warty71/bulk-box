// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quick_add_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuickAddItem {
  YgoCard get card;
  String get setCode;
  String get setRarity;
  int get quantity;

  /// Create a copy of QuickAddItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuickAddItemCopyWith<QuickAddItem> get copyWith =>
      _$QuickAddItemCopyWithImpl<QuickAddItem>(
          this as QuickAddItem, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuickAddItem &&
            (identical(other.card, card) || other.card == card) &&
            (identical(other.setCode, setCode) || other.setCode == setCode) &&
            (identical(other.setRarity, setRarity) ||
                other.setRarity == setRarity) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, card, setCode, setRarity, quantity);

  @override
  String toString() {
    return 'QuickAddItem(card: $card, setCode: $setCode, setRarity: $setRarity, quantity: $quantity)';
  }
}

/// @nodoc
abstract mixin class $QuickAddItemCopyWith<$Res> {
  factory $QuickAddItemCopyWith(
          QuickAddItem value, $Res Function(QuickAddItem) _then) =
      _$QuickAddItemCopyWithImpl;
  @useResult
  $Res call({YgoCard card, String setCode, String setRarity, int quantity});
}

/// @nodoc
class _$QuickAddItemCopyWithImpl<$Res> implements $QuickAddItemCopyWith<$Res> {
  _$QuickAddItemCopyWithImpl(this._self, this._then);

  final QuickAddItem _self;
  final $Res Function(QuickAddItem) _then;

  /// Create a copy of QuickAddItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? card = null,
    Object? setCode = null,
    Object? setRarity = null,
    Object? quantity = null,
  }) {
    return _then(_self.copyWith(
      card: null == card
          ? _self.card
          : card // ignore: cast_nullable_to_non_nullable
              as YgoCard,
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
    ));
  }
}

/// Adds pattern-matching-related methods to [QuickAddItem].
extension QuickAddItemPatterns on QuickAddItem {
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
    TResult Function(_QuickAddItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuickAddItem() when $default != null:
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
    TResult Function(_QuickAddItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuickAddItem():
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
    TResult? Function(_QuickAddItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuickAddItem() when $default != null:
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
            YgoCard card, String setCode, String setRarity, int quantity)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuickAddItem() when $default != null:
        return $default(
            _that.card, _that.setCode, _that.setRarity, _that.quantity);
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
            YgoCard card, String setCode, String setRarity, int quantity)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuickAddItem():
        return $default(
            _that.card, _that.setCode, _that.setRarity, _that.quantity);
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
            YgoCard card, String setCode, String setRarity, int quantity)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuickAddItem() when $default != null:
        return $default(
            _that.card, _that.setCode, _that.setRarity, _that.quantity);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _QuickAddItem implements QuickAddItem {
  const _QuickAddItem(
      {required this.card,
      required this.setCode,
      required this.setRarity,
      required this.quantity});

  @override
  final YgoCard card;
  @override
  final String setCode;
  @override
  final String setRarity;
  @override
  final int quantity;

  /// Create a copy of QuickAddItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuickAddItemCopyWith<_QuickAddItem> get copyWith =>
      __$QuickAddItemCopyWithImpl<_QuickAddItem>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuickAddItem &&
            (identical(other.card, card) || other.card == card) &&
            (identical(other.setCode, setCode) || other.setCode == setCode) &&
            (identical(other.setRarity, setRarity) ||
                other.setRarity == setRarity) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, card, setCode, setRarity, quantity);

  @override
  String toString() {
    return 'QuickAddItem(card: $card, setCode: $setCode, setRarity: $setRarity, quantity: $quantity)';
  }
}

/// @nodoc
abstract mixin class _$QuickAddItemCopyWith<$Res>
    implements $QuickAddItemCopyWith<$Res> {
  factory _$QuickAddItemCopyWith(
          _QuickAddItem value, $Res Function(_QuickAddItem) _then) =
      __$QuickAddItemCopyWithImpl;
  @override
  @useResult
  $Res call({YgoCard card, String setCode, String setRarity, int quantity});
}

/// @nodoc
class __$QuickAddItemCopyWithImpl<$Res>
    implements _$QuickAddItemCopyWith<$Res> {
  __$QuickAddItemCopyWithImpl(this._self, this._then);

  final _QuickAddItem _self;
  final $Res Function(_QuickAddItem) _then;

  /// Create a copy of QuickAddItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? card = null,
    Object? setCode = null,
    Object? setRarity = null,
    Object? quantity = null,
  }) {
    return _then(_QuickAddItem(
      card: null == card
          ? _self.card
          : card // ignore: cast_nullable_to_non_nullable
              as YgoCard,
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
    ));
  }
}

/// @nodoc
mixin _$QuickAddState {
  Map<String, QuickAddItem> get cart;

  /// Create a copy of QuickAddState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuickAddStateCopyWith<QuickAddState> get copyWith =>
      _$QuickAddStateCopyWithImpl<QuickAddState>(
          this as QuickAddState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuickAddState &&
            const DeepCollectionEquality().equals(other.cart, cart));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(cart));

  @override
  String toString() {
    return 'QuickAddState(cart: $cart)';
  }
}

/// @nodoc
abstract mixin class $QuickAddStateCopyWith<$Res> {
  factory $QuickAddStateCopyWith(
          QuickAddState value, $Res Function(QuickAddState) _then) =
      _$QuickAddStateCopyWithImpl;
  @useResult
  $Res call({Map<String, QuickAddItem> cart});
}

/// @nodoc
class _$QuickAddStateCopyWithImpl<$Res>
    implements $QuickAddStateCopyWith<$Res> {
  _$QuickAddStateCopyWithImpl(this._self, this._then);

  final QuickAddState _self;
  final $Res Function(QuickAddState) _then;

  /// Create a copy of QuickAddState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cart = null,
  }) {
    return _then(_self.copyWith(
      cart: null == cart
          ? _self.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as Map<String, QuickAddItem>,
    ));
  }
}

/// Adds pattern-matching-related methods to [QuickAddState].
extension QuickAddStatePatterns on QuickAddState {
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
    TResult Function(_QuickAddState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuickAddState() when $default != null:
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
    TResult Function(_QuickAddState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuickAddState():
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
    TResult? Function(_QuickAddState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuickAddState() when $default != null:
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
    TResult Function(Map<String, QuickAddItem> cart)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuickAddState() when $default != null:
        return $default(_that.cart);
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
    TResult Function(Map<String, QuickAddItem> cart) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuickAddState():
        return $default(_that.cart);
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
    TResult? Function(Map<String, QuickAddItem> cart)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuickAddState() when $default != null:
        return $default(_that.cart);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _QuickAddState extends QuickAddState {
  const _QuickAddState(
      {final Map<String, QuickAddItem> cart = const <String, QuickAddItem>{}})
      : _cart = cart,
        super._();

  final Map<String, QuickAddItem> _cart;
  @override
  @JsonKey()
  Map<String, QuickAddItem> get cart {
    if (_cart is EqualUnmodifiableMapView) return _cart;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cart);
  }

  /// Create a copy of QuickAddState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuickAddStateCopyWith<_QuickAddState> get copyWith =>
      __$QuickAddStateCopyWithImpl<_QuickAddState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuickAddState &&
            const DeepCollectionEquality().equals(other._cart, _cart));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cart));

  @override
  String toString() {
    return 'QuickAddState(cart: $cart)';
  }
}

/// @nodoc
abstract mixin class _$QuickAddStateCopyWith<$Res>
    implements $QuickAddStateCopyWith<$Res> {
  factory _$QuickAddStateCopyWith(
          _QuickAddState value, $Res Function(_QuickAddState) _then) =
      __$QuickAddStateCopyWithImpl;
  @override
  @useResult
  $Res call({Map<String, QuickAddItem> cart});
}

/// @nodoc
class __$QuickAddStateCopyWithImpl<$Res>
    implements _$QuickAddStateCopyWith<$Res> {
  __$QuickAddStateCopyWithImpl(this._self, this._then);

  final _QuickAddState _self;
  final $Res Function(_QuickAddState) _then;

  /// Create a copy of QuickAddState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cart = null,
  }) {
    return _then(_QuickAddState(
      cart: null == cart
          ? _self._cart
          : cart // ignore: cast_nullable_to_non_nullable
              as Map<String, QuickAddItem>,
    ));
  }
}

// dart format on
