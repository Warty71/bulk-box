import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_item.freezed.dart';

@freezed
abstract class CollectionItemEntity with _$CollectionItemEntity {
  const factory CollectionItemEntity({
    required int cardId,
    required String setCode,
    required String setRarity,
    required int quantity,
    String? condition,
    required DateTime dateAdded,
    /// Box this item is in; null means unboxed.
    int? boxId,
  }) = _CollectionItemEntity;
}
