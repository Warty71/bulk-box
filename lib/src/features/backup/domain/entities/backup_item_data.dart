import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup_item_data.freezed.dart';
part 'backup_item_data.g.dart';

@freezed
abstract class BackupItemData with _$BackupItemData {
  const factory BackupItemData({
    @JsonKey(name: 'card_id') required int cardId,
    @JsonKey(name: 'set_code') required String setCode,
    @JsonKey(name: 'set_rarity') required String setRarity,
    required int quantity,
    String? condition,
    @JsonKey(name: 'date_added') required DateTime dateAdded,
  }) = _BackupItemData;

  factory BackupItemData.fromJson(Map<String, dynamic> json) =>
      _$BackupItemDataFromJson(json);
}
