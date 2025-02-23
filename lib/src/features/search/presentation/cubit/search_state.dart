import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ygo_collector/src/core/ygo_cards/data/entities/ygo_card.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.loaded({
    required List<YgoCard> cards,
    required String lastQuery,
  }) = _Loaded;
  const factory SearchState.error(String message) = _Error;
}
