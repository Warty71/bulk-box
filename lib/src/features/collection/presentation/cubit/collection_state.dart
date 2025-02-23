import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/card.dart';

part 'collection_state.freezed.dart';

@freezed
class CollectionState with _$CollectionState {
  const factory CollectionState.initial() = _Initial;
  const factory CollectionState.loading() = _Loading;
  const factory CollectionState.loaded({
    required List<Card> cards,
    required bool hasReachedMax,
  }) = _Loaded;
  const factory CollectionState.error(String message) = _Error;
}
