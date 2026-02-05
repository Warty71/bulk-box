import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';

part 'collection_state.freezed.dart';

@freezed
abstract class CollectionState with _$CollectionState {
  const factory CollectionState.initial() = _Initial;
  const factory CollectionState.loading() = _Loading;
  const factory CollectionState.loaded({
    required List<CollectionEntry> collectionEntries,
    @Default(false) bool searchBarVisible,
    @Default('') String searchQuery,
    /// When set, only items in this box are shown; null = all items.
    int? selectedBoxId,
    /// Display name for selected box (e.g. "Unboxed" or box name).
    String? selectedBoxName,
  }) = _Loaded;
  const factory CollectionState.error(String message) = _Error;
}
