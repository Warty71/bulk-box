// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BackupState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BackupState()';
  }
}

/// @nodoc
class $BackupStateCopyWith<$Res> {
  $BackupStateCopyWith(BackupState _, $Res Function(BackupState) __);
}

/// Adds pattern-matching-related methods to [BackupState].
extension BackupStatePatterns on BackupState {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Exporting value)? exporting,
    TResult Function(_ExportSuccess value)? exportSuccess,
    TResult Function(_Importing value)? importing,
    TResult Function(_ImportSuccess value)? importSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _Exporting() when exporting != null:
        return exporting(_that);
      case _ExportSuccess() when exportSuccess != null:
        return exportSuccess(_that);
      case _Importing() when importing != null:
        return importing(_that);
      case _ImportSuccess() when importSuccess != null:
        return importSuccess(_that);
      case _Error() when error != null:
        return error(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Exporting value) exporting,
    required TResult Function(_ExportSuccess value) exportSuccess,
    required TResult Function(_Importing value) importing,
    required TResult Function(_ImportSuccess value) importSuccess,
    required TResult Function(_Error value) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial(_that);
      case _Exporting():
        return exporting(_that);
      case _ExportSuccess():
        return exportSuccess(_that);
      case _Importing():
        return importing(_that);
      case _ImportSuccess():
        return importSuccess(_that);
      case _Error():
        return error(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Exporting value)? exporting,
    TResult? Function(_ExportSuccess value)? exportSuccess,
    TResult? Function(_Importing value)? importing,
    TResult? Function(_ImportSuccess value)? importSuccess,
    TResult? Function(_Error value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _Exporting() when exporting != null:
        return exporting(_that);
      case _ExportSuccess() when exportSuccess != null:
        return exportSuccess(_that);
      case _Importing() when importing != null:
        return importing(_that);
      case _ImportSuccess() when importSuccess != null:
        return importSuccess(_that);
      case _Error() when error != null:
        return error(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? exporting,
    TResult Function(String filePath)? exportSuccess,
    TResult Function()? importing,
    TResult Function(ImportResult result)? importSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Exporting() when exporting != null:
        return exporting();
      case _ExportSuccess() when exportSuccess != null:
        return exportSuccess(_that.filePath);
      case _Importing() when importing != null:
        return importing();
      case _ImportSuccess() when importSuccess != null:
        return importSuccess(_that.result);
      case _Error() when error != null:
        return error(_that.message);
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
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() exporting,
    required TResult Function(String filePath) exportSuccess,
    required TResult Function() importing,
    required TResult Function(ImportResult result) importSuccess,
    required TResult Function(String message) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial();
      case _Exporting():
        return exporting();
      case _ExportSuccess():
        return exportSuccess(_that.filePath);
      case _Importing():
        return importing();
      case _ImportSuccess():
        return importSuccess(_that.result);
      case _Error():
        return error(_that.message);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? exporting,
    TResult? Function(String filePath)? exportSuccess,
    TResult? Function()? importing,
    TResult? Function(ImportResult result)? importSuccess,
    TResult? Function(String message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Exporting() when exporting != null:
        return exporting();
      case _ExportSuccess() when exportSuccess != null:
        return exportSuccess(_that.filePath);
      case _Importing() when importing != null:
        return importing();
      case _ImportSuccess() when importSuccess != null:
        return importSuccess(_that.result);
      case _Error() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements BackupState {
  const _Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BackupState.initial()';
  }
}

/// @nodoc

class _Exporting implements BackupState {
  const _Exporting();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Exporting);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BackupState.exporting()';
  }
}

/// @nodoc

class _ExportSuccess implements BackupState {
  const _ExportSuccess(this.filePath);

  final String filePath;

  /// Create a copy of BackupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExportSuccessCopyWith<_ExportSuccess> get copyWith =>
      __$ExportSuccessCopyWithImpl<_ExportSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExportSuccess &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filePath);

  @override
  String toString() {
    return 'BackupState.exportSuccess(filePath: $filePath)';
  }
}

/// @nodoc
abstract mixin class _$ExportSuccessCopyWith<$Res>
    implements $BackupStateCopyWith<$Res> {
  factory _$ExportSuccessCopyWith(
          _ExportSuccess value, $Res Function(_ExportSuccess) _then) =
      __$ExportSuccessCopyWithImpl;
  @useResult
  $Res call({String filePath});
}

/// @nodoc
class __$ExportSuccessCopyWithImpl<$Res>
    implements _$ExportSuccessCopyWith<$Res> {
  __$ExportSuccessCopyWithImpl(this._self, this._then);

  final _ExportSuccess _self;
  final $Res Function(_ExportSuccess) _then;

  /// Create a copy of BackupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? filePath = null,
  }) {
    return _then(_ExportSuccess(
      null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Importing implements BackupState {
  const _Importing();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Importing);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BackupState.importing()';
  }
}

/// @nodoc

class _ImportSuccess implements BackupState {
  const _ImportSuccess(this.result);

  final ImportResult result;

  /// Create a copy of BackupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImportSuccessCopyWith<_ImportSuccess> get copyWith =>
      __$ImportSuccessCopyWithImpl<_ImportSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImportSuccess &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  @override
  String toString() {
    return 'BackupState.importSuccess(result: $result)';
  }
}

/// @nodoc
abstract mixin class _$ImportSuccessCopyWith<$Res>
    implements $BackupStateCopyWith<$Res> {
  factory _$ImportSuccessCopyWith(
          _ImportSuccess value, $Res Function(_ImportSuccess) _then) =
      __$ImportSuccessCopyWithImpl;
  @useResult
  $Res call({ImportResult result});

  $ImportResultCopyWith<$Res> get result;
}

/// @nodoc
class __$ImportSuccessCopyWithImpl<$Res>
    implements _$ImportSuccessCopyWith<$Res> {
  __$ImportSuccessCopyWithImpl(this._self, this._then);

  final _ImportSuccess _self;
  final $Res Function(_ImportSuccess) _then;

  /// Create a copy of BackupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? result = null,
  }) {
    return _then(_ImportSuccess(
      null == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as ImportResult,
    ));
  }

  /// Create a copy of BackupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImportResultCopyWith<$Res> get result {
    return $ImportResultCopyWith<$Res>(_self.result, (value) {
      return _then(_self.copyWith(result: value));
    });
  }
}

/// @nodoc

class _Error implements BackupState {
  const _Error(this.message);

  final String message;

  /// Create a copy of BackupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Error &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'BackupState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res>
    implements $BackupStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) =
      __$ErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

  /// Create a copy of BackupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_Error(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
