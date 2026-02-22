// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupManifest _$BackupManifestFromJson(Map<String, dynamic> json) =>
    _BackupManifest(
      version: (json['version'] as num).toInt(),
      schemaVersion: (json['schema_version'] as num).toInt(),
      exportedAt: DateTime.parse(json['exported_at'] as String),
      cards: (json['cards'] as List<dynamic>)
          .map((e) => BackupCardData.fromJson(e as Map<String, dynamic>))
          .toList(),
      boxes: (json['boxes'] as List<dynamic>)
          .map((e) => BackupBoxData.fromJson(e as Map<String, dynamic>))
          .toList(),
      unboxedItems: (json['unboxed_items'] as List<dynamic>)
          .map((e) => BackupItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BackupManifestToJson(_BackupManifest instance) =>
    <String, dynamic>{
      'version': instance.version,
      'schema_version': instance.schemaVersion,
      'exported_at': instance.exportedAt.toIso8601String(),
      'cards': instance.cards,
      'boxes': instance.boxes,
      'unboxed_items': instance.unboxedItems,
    };
