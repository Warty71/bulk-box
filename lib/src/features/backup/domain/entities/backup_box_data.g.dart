// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_box_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupBoxData _$BackupBoxDataFromJson(Map<String, dynamic> json) =>
    _BackupBoxData(
      name: json['name'] as String,
      color: json['color'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      items: (json['items'] as List<dynamic>)
          .map((e) => BackupItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BackupBoxDataToJson(_BackupBoxData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'sort_order': instance.sortOrder,
      'items': instance.items,
    };
