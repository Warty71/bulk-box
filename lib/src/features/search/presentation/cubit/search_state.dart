import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bulk_box/src/features/search/domain/entities/search_result_entry.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.loaded({
    required List<SearchResultEntry> entries,
    required Map<String, List<SearchResultEntry>> grouped,
    required String lastQuery,
  }) = _Loaded;
  const factory SearchState.error(String message) = _Error;
}
