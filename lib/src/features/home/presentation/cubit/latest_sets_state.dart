import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/set_info.dart';

part 'latest_sets_state.freezed.dart';

@freezed
class LatestSetsState with _$LatestSetsState {
  const factory LatestSetsState.initial() = _Initial;
  const factory LatestSetsState.loading() = _Loading;
  const factory LatestSetsState.loaded(List<SetInfo> sets) = _Loaded;
  const factory LatestSetsState.failure(String? message) = _Failure;
}
