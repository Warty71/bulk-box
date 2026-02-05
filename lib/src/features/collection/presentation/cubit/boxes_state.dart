import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';

part 'boxes_state.freezed.dart';

@freezed
abstract class BoxesState with _$BoxesState {
  const factory BoxesState.initial() = _Initial;
  const factory BoxesState.loading() = _Loading;
  const factory BoxesState.loaded(List<Box> boxes) = _Loaded;
  const factory BoxesState.error(String message) = _Error;
}
