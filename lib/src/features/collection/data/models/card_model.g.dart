// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardModelImpl _$$CardModelImplFromJson(Map<String, dynamic> json) =>
    _$CardModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      desc: json['desc'] as String,
      race: json['race'] as String,
      attribute: json['attribute'] as String?,
      level: (json['level'] as num?)?.toInt(),
      atk: (json['atk'] as num?)?.toInt(),
      def: (json['def'] as num?)?.toInt(),
      cardImages: (json['card_images'] as List<dynamic>)
          .map((e) => CardImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cardSets: (json['card_sets'] as List<dynamic>?)
              ?.map((e) => CardSetModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$$CardModelImplToJson(_$CardModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'desc': instance.desc,
      'race': instance.race,
      'attribute': instance.attribute,
      'level': instance.level,
      'atk': instance.atk,
      'def': instance.def,
      'card_images': instance.cardImages,
      'card_sets': instance.cardSets,
    };

_$CardImageModelImpl _$$CardImageModelImplFromJson(Map<String, dynamic> json) =>
    _$CardImageModelImpl(
      id: (json['id'] as num).toInt(),
      imageUrl: json['image_url'] as String,
      imageUrlSmall: json['image_url_small'] as String,
    );

Map<String, dynamic> _$$CardImageModelImplToJson(
        _$CardImageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_url': instance.imageUrl,
      'image_url_small': instance.imageUrlSmall,
    };

_$CardSetModelImpl _$$CardSetModelImplFromJson(Map<String, dynamic> json) =>
    _$CardSetModelImpl(
      setName: json['set_name'] as String,
      setCode: json['set_code'] as String,
      setRarity: json['set_rarity'] as String,
      setPrice: json['set_price'] as String,
    );

Map<String, dynamic> _$$CardSetModelImplToJson(_$CardSetModelImpl instance) =>
    <String, dynamic>{
      'set_name': instance.setName,
      'set_code': instance.setCode,
      'set_rarity': instance.setRarity,
      'set_price': instance.setPrice,
    };
