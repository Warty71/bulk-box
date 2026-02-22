// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_item_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupItemData _$BackupItemDataFromJson(Map<String, dynamic> json) =>
    _BackupItemData(
      cardId: (json['card_id'] as num).toInt(),
      setCode: json['set_code'] as String,
      setRarity: json['set_rarity'] as String,
      quantity: (json['quantity'] as num).toInt(),
      condition: json['condition'] as String?,
      dateAdded: DateTime.parse(json['date_added'] as String),
    );

Map<String, dynamic> _$BackupItemDataToJson(_BackupItemData instance) =>
    <String, dynamic>{
      'card_id': instance.cardId,
      'set_code': instance.setCode,
      'set_rarity': instance.setRarity,
      'quantity': instance.quantity,
      'condition': instance.condition,
      'date_added': instance.dateAdded.toIso8601String(),
    };
