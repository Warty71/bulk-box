// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardImpl _$$CardImplFromJson(Map<String, dynamic> json) => _$CardImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      race: json['race'] as String,
      attribute: json['attribute'] as String?,
      level: (json['level'] as num?)?.toInt(),
      atk: (json['atk'] as num?)?.toInt(),
      def: (json['def'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String,
      setCode: json['setCode'] as String,
      setRarity: json['setRarity'] as String,
      isLocalImageAvailable: json['isLocalImageAvailable'] as bool? ?? false,
    );

Map<String, dynamic> _$$CardImplToJson(_$CardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
      'race': instance.race,
      'attribute': instance.attribute,
      'level': instance.level,
      'atk': instance.atk,
      'def': instance.def,
      'imageUrl': instance.imageUrl,
      'setCode': instance.setCode,
      'setRarity': instance.setRarity,
      'isLocalImageAvailable': instance.isLocalImageAvailable,
    };
