import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup_card_set_data.freezed.dart';
part 'backup_card_set_data.g.dart';

@freezed
abstract class BackupCardSetData with _$BackupCardSetData {
  const factory BackupCardSetData({
    @JsonKey(name: 'set_name') required String setName,
    @JsonKey(name: 'set_code') required String setCode,
    @JsonKey(name: 'set_rarity') required String setRarity,
    @JsonKey(name: 'set_edition') String? setEdition,
    @JsonKey(name: 'set_price') String? setPrice,
    @JsonKey(name: 'set_price_low') String? setPriceLow,
    @JsonKey(name: 'set_url') String? setUrl,
  }) = _BackupCardSetData;

  factory BackupCardSetData.fromJson(Map<String, dynamic> json) =>
      _$BackupCardSetDataFromJson(json);
}
