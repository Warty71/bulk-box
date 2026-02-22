// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupCardData _$BackupCardDataFromJson(Map<String, dynamic> json) =>
    _BackupCardData(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      race: json['race'] as String,
      frameType: json['frame_type'] as String?,
      attribute: json['attribute'] as String?,
      level: (json['level'] as num?)?.toInt(),
      atk: (json['atk'] as num?)?.toInt(),
      def: (json['def'] as num?)?.toInt(),
      archetype: json['archetype'] as String?,
      imageUrl: json['image_url'] as String,
      cardSets: (json['card_sets'] as List<dynamic>)
          .map((e) => BackupCardSetData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BackupCardDataToJson(_BackupCardData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
      'race': instance.race,
      'frame_type': instance.frameType,
      'attribute': instance.attribute,
      'level': instance.level,
      'atk': instance.atk,
      'def': instance.def,
      'archetype': instance.archetype,
      'image_url': instance.imageUrl,
      'card_sets': instance.cardSets,
    };
