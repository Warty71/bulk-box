// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_search_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CardSearchFilters {
  /// Multi-select: OR within the group (card matches if frameType == any).
  List<CardType> get types;

  /// Multi-select: OR within the group (card matches if type contains any keyword).
  List<MonsterSubtype> get subtypes;
  CardAttribute? get attribute;
  CardRace? get race;
  int? get level;
  String? get archetype;
  BanlistFilter? get banlist;
  bool get staplesOnly;
  CardSortBy? get sortBy;

  /// Create a copy of CardSearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardSearchFiltersCopyWith<CardSearchFilters> get copyWith =>
      _$CardSearchFiltersCopyWithImpl<CardSearchFilters>(
          this as CardSearchFilters, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardSearchFilters &&
            const DeepCollectionEquality().equals(other.types, types) &&
            const DeepCollectionEquality().equals(other.subtypes, subtypes) &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute) &&
            (identical(other.race, race) || other.race == race) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.archetype, archetype) ||
                other.archetype == archetype) &&
            (identical(other.banlist, banlist) || other.banlist == banlist) &&
            (identical(other.staplesOnly, staplesOnly) ||
                other.staplesOnly == staplesOnly) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(types),
      const DeepCollectionEquality().hash(subtypes),
      attribute,
      race,
      level,
      archetype,
      banlist,
      staplesOnly,
      sortBy);

  @override
  String toString() {
    return 'CardSearchFilters(types: $types, subtypes: $subtypes, attribute: $attribute, race: $race, level: $level, archetype: $archetype, banlist: $banlist, staplesOnly: $staplesOnly, sortBy: $sortBy)';
  }
}

/// @nodoc
abstract mixin class $CardSearchFiltersCopyWith<$Res> {
  factory $CardSearchFiltersCopyWith(
          CardSearchFilters value, $Res Function(CardSearchFilters) _then) =
      _$CardSearchFiltersCopyWithImpl;
  @useResult
  $Res call(
      {List<CardType> types,
      List<MonsterSubtype> subtypes,
      CardAttribute? attribute,
      CardRace? race,
      int? level,
      String? archetype,
      BanlistFilter? banlist,
      bool staplesOnly,
      CardSortBy? sortBy});
}

/// @nodoc
class _$CardSearchFiltersCopyWithImpl<$Res>
    implements $CardSearchFiltersCopyWith<$Res> {
  _$CardSearchFiltersCopyWithImpl(this._self, this._then);

  final CardSearchFilters _self;
  final $Res Function(CardSearchFilters) _then;

  /// Create a copy of CardSearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? types = null,
    Object? subtypes = null,
    Object? attribute = freezed,
    Object? race = freezed,
    Object? level = freezed,
    Object? archetype = freezed,
    Object? banlist = freezed,
    Object? staplesOnly = null,
    Object? sortBy = freezed,
  }) {
    return _then(_self.copyWith(
      types: null == types
          ? _self.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<CardType>,
      subtypes: null == subtypes
          ? _self.subtypes
          : subtypes // ignore: cast_nullable_to_non_nullable
              as List<MonsterSubtype>,
      attribute: freezed == attribute
          ? _self.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as CardAttribute?,
      race: freezed == race
          ? _self.race
          : race // ignore: cast_nullable_to_non_nullable
              as CardRace?,
      level: freezed == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      archetype: freezed == archetype
          ? _self.archetype
          : archetype // ignore: cast_nullable_to_non_nullable
              as String?,
      banlist: freezed == banlist
          ? _self.banlist
          : banlist // ignore: cast_nullable_to_non_nullable
              as BanlistFilter?,
      staplesOnly: null == staplesOnly
          ? _self.staplesOnly
          : staplesOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      sortBy: freezed == sortBy
          ? _self.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as CardSortBy?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CardSearchFilters].
extension CardSearchFiltersPatterns on CardSearchFilters {
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
    TResult Function(_CardSearchFilters value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardSearchFilters() when $default != null:
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
    TResult Function(_CardSearchFilters value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardSearchFilters():
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
    TResult? Function(_CardSearchFilters value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardSearchFilters() when $default != null:
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
            List<CardType> types,
            List<MonsterSubtype> subtypes,
            CardAttribute? attribute,
            CardRace? race,
            int? level,
            String? archetype,
            BanlistFilter? banlist,
            bool staplesOnly,
            CardSortBy? sortBy)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardSearchFilters() when $default != null:
        return $default(
            _that.types,
            _that.subtypes,
            _that.attribute,
            _that.race,
            _that.level,
            _that.archetype,
            _that.banlist,
            _that.staplesOnly,
            _that.sortBy);
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
            List<CardType> types,
            List<MonsterSubtype> subtypes,
            CardAttribute? attribute,
            CardRace? race,
            int? level,
            String? archetype,
            BanlistFilter? banlist,
            bool staplesOnly,
            CardSortBy? sortBy)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardSearchFilters():
        return $default(
            _that.types,
            _that.subtypes,
            _that.attribute,
            _that.race,
            _that.level,
            _that.archetype,
            _that.banlist,
            _that.staplesOnly,
            _that.sortBy);
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
            List<CardType> types,
            List<MonsterSubtype> subtypes,
            CardAttribute? attribute,
            CardRace? race,
            int? level,
            String? archetype,
            BanlistFilter? banlist,
            bool staplesOnly,
            CardSortBy? sortBy)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardSearchFilters() when $default != null:
        return $default(
            _that.types,
            _that.subtypes,
            _that.attribute,
            _that.race,
            _that.level,
            _that.archetype,
            _that.banlist,
            _that.staplesOnly,
            _that.sortBy);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CardSearchFilters extends CardSearchFilters {
  const _CardSearchFilters(
      {final List<CardType> types = const <CardType>[],
      final List<MonsterSubtype> subtypes = const <MonsterSubtype>[],
      this.attribute,
      this.race,
      this.level,
      this.archetype,
      this.banlist,
      this.staplesOnly = false,
      this.sortBy})
      : _types = types,
        _subtypes = subtypes,
        super._();

  /// Multi-select: OR within the group (card matches if frameType == any).
  final List<CardType> _types;

  /// Multi-select: OR within the group (card matches if frameType == any).
  @override
  @JsonKey()
  List<CardType> get types {
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_types);
  }

  /// Multi-select: OR within the group (card matches if type contains any keyword).
  final List<MonsterSubtype> _subtypes;

  /// Multi-select: OR within the group (card matches if type contains any keyword).
  @override
  @JsonKey()
  List<MonsterSubtype> get subtypes {
    if (_subtypes is EqualUnmodifiableListView) return _subtypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subtypes);
  }

  @override
  final CardAttribute? attribute;
  @override
  final CardRace? race;
  @override
  final int? level;
  @override
  final String? archetype;
  @override
  final BanlistFilter? banlist;
  @override
  @JsonKey()
  final bool staplesOnly;
  @override
  final CardSortBy? sortBy;

  /// Create a copy of CardSearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CardSearchFiltersCopyWith<_CardSearchFilters> get copyWith =>
      __$CardSearchFiltersCopyWithImpl<_CardSearchFilters>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CardSearchFilters &&
            const DeepCollectionEquality().equals(other._types, _types) &&
            const DeepCollectionEquality().equals(other._subtypes, _subtypes) &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute) &&
            (identical(other.race, race) || other.race == race) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.archetype, archetype) ||
                other.archetype == archetype) &&
            (identical(other.banlist, banlist) || other.banlist == banlist) &&
            (identical(other.staplesOnly, staplesOnly) ||
                other.staplesOnly == staplesOnly) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_types),
      const DeepCollectionEquality().hash(_subtypes),
      attribute,
      race,
      level,
      archetype,
      banlist,
      staplesOnly,
      sortBy);

  @override
  String toString() {
    return 'CardSearchFilters(types: $types, subtypes: $subtypes, attribute: $attribute, race: $race, level: $level, archetype: $archetype, banlist: $banlist, staplesOnly: $staplesOnly, sortBy: $sortBy)';
  }
}

/// @nodoc
abstract mixin class _$CardSearchFiltersCopyWith<$Res>
    implements $CardSearchFiltersCopyWith<$Res> {
  factory _$CardSearchFiltersCopyWith(
          _CardSearchFilters value, $Res Function(_CardSearchFilters) _then) =
      __$CardSearchFiltersCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<CardType> types,
      List<MonsterSubtype> subtypes,
      CardAttribute? attribute,
      CardRace? race,
      int? level,
      String? archetype,
      BanlistFilter? banlist,
      bool staplesOnly,
      CardSortBy? sortBy});
}

/// @nodoc
class __$CardSearchFiltersCopyWithImpl<$Res>
    implements _$CardSearchFiltersCopyWith<$Res> {
  __$CardSearchFiltersCopyWithImpl(this._self, this._then);

  final _CardSearchFilters _self;
  final $Res Function(_CardSearchFilters) _then;

  /// Create a copy of CardSearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? types = null,
    Object? subtypes = null,
    Object? attribute = freezed,
    Object? race = freezed,
    Object? level = freezed,
    Object? archetype = freezed,
    Object? banlist = freezed,
    Object? staplesOnly = null,
    Object? sortBy = freezed,
  }) {
    return _then(_CardSearchFilters(
      types: null == types
          ? _self._types
          : types // ignore: cast_nullable_to_non_nullable
              as List<CardType>,
      subtypes: null == subtypes
          ? _self._subtypes
          : subtypes // ignore: cast_nullable_to_non_nullable
              as List<MonsterSubtype>,
      attribute: freezed == attribute
          ? _self.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as CardAttribute?,
      race: freezed == race
          ? _self.race
          : race // ignore: cast_nullable_to_non_nullable
              as CardRace?,
      level: freezed == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      archetype: freezed == archetype
          ? _self.archetype
          : archetype // ignore: cast_nullable_to_non_nullable
              as String?,
      banlist: freezed == banlist
          ? _self.banlist
          : banlist // ignore: cast_nullable_to_non_nullable
              as BanlistFilter?,
      staplesOnly: null == staplesOnly
          ? _self.staplesOnly
          : staplesOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      sortBy: freezed == sortBy
          ? _self.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as CardSortBy?,
    ));
  }
}

// dart format on
