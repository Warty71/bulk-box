// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ygo_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_YgoCard _$YgoCardFromJson(Map<String, dynamic> json) => _YgoCard(
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
      cardSets: (json['cardSets'] as List<dynamic>)
          .map((e) => CardSet.fromJson(e as Map<String, dynamic>))
          .toList(),
      isLocalImageAvailable: json['isLocalImageAvailable'] as bool? ?? false,
    );

Map<String, dynamic> _$YgoCardToJson(_YgoCard instance) => <String, dynamic>{
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
      'cardSets': instance.cardSets,
      'isLocalImageAvailable': instance.isLocalImageAvailable,
    };

_CardSet _$CardSetFromJson(Map<String, dynamic> json) => _CardSet(
      setName: json['setName'] as String,
      setCode: json['setCode'] as String,
      setRarity: json['setRarity'] as String,
    );

Map<String, dynamic> _$CardSetToJson(_CardSet instance) => <String, dynamic>{
      'setName': instance.setName,
      'setCode': instance.setCode,
      'setRarity': instance.setRarity,
    };
