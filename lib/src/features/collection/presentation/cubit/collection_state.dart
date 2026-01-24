import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';

part 'collection_state.freezed.dart';

@freezed
abstract class CollectionState with _$CollectionState {
  const factory CollectionState.initial() = _Initial;
  const factory CollectionState.loading() = _Loading;
  const factory CollectionState.loaded({
    required List<CollectionItemEntity> items,
  }) = _Loaded;
  const factory CollectionState.error(String message) = _Error;
}
