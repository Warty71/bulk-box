import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/models/set_info_model.dart';

part 'latest_sets_state.freezed.dart';

@freezed
class LatestSetsState with _$LatestSetsState {
  const factory LatestSetsState.initial() = _Initial;
  const factory LatestSetsState.loading() = _Loading;
  const factory LatestSetsState.loaded(List<SetInfoModel> sets) = _Loaded;
  const factory LatestSetsState.failure(String? message) = _Failure;
}
