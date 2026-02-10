// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CardModel _$CardModelFromJson(Map<String, dynamic> json) => _CardModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      desc: json['desc'] as String,
      race: json['race'] as String,
      frameType: json['frameType'] as String?,
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

Map<String, dynamic> _$CardModelToJson(_CardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'desc': instance.desc,
      'race': instance.race,
      'frameType': instance.frameType,
      'attribute': instance.attribute,
      'level': instance.level,
      'atk': instance.atk,
      'def': instance.def,
      'card_images': instance.cardImages,
      'card_sets': instance.cardSets,
    };

_CardImageModel _$CardImageModelFromJson(Map<String, dynamic> json) =>
    _CardImageModel(
      id: (json['id'] as num).toInt(),
      imageUrl: json['image_url'] as String,
      imageUrlSmall: json['image_url_small'] as String,
    );

Map<String, dynamic> _$CardImageModelToJson(_CardImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_url': instance.imageUrl,
      'image_url_small': instance.imageUrlSmall,
    };

_CardSetModel _$CardSetModelFromJson(Map<String, dynamic> json) =>
    _CardSetModel(
      setName: json['set_name'] as String,
      setCode: json['set_code'] as String,
      setRarity: json['set_rarity'] as String,
      setEdition: json['set_edition'] as String?,
      setPrice: json['set_price'] as String?,
      setPriceLow: json['set_price_low'] as String?,
      setUrl: json['set_url'] as String?,
    );

Map<String, dynamic> _$CardSetModelToJson(_CardSetModel instance) =>
    <String, dynamic>{
      'set_name': instance.setName,
      'set_code': instance.setCode,
      'set_rarity': instance.setRarity,
      'set_edition': instance.setEdition,
      'set_price': instance.setPrice,
      'set_price_low': instance.setPriceLow,
      'set_url': instance.setUrl,
    };
