// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_card_set_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupCardSetData _$BackupCardSetDataFromJson(Map<String, dynamic> json) =>
    _BackupCardSetData(
      setName: json['set_name'] as String,
      setCode: json['set_code'] as String,
      setRarity: json['set_rarity'] as String,
      setEdition: json['set_edition'] as String?,
      setPrice: json['set_price'] as String?,
      setPriceLow: json['set_price_low'] as String?,
      setUrl: json['set_url'] as String?,
    );

Map<String, dynamic> _$BackupCardSetDataToJson(_BackupCardSetData instance) =>
    <String, dynamic>{
      'set_name': instance.setName,
      'set_code': instance.setCode,
      'set_rarity': instance.setRarity,
      'set_edition': instance.setEdition,
      'set_price': instance.setPrice,
      'set_price_low': instance.setPriceLow,
      'set_url': instance.setUrl,
    };
