// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SetInfoModel _$SetInfoModelFromJson(Map<String, dynamic> json) =>
    _SetInfoModel(
      setName: json['set_name'] as String,
      setCode: json['set_code'] as String,
      numOfCards: (json['num_of_cards'] as num).toInt(),
      tcgDate: json['tcg_date'] as String,
      setImage: json['set_image'] as String?,
    );

Map<String, dynamic> _$SetInfoModelToJson(_SetInfoModel instance) =>
    <String, dynamic>{
      'set_name': instance.setName,
      'set_code': instance.setCode,
      'num_of_cards': instance.numOfCards,
      'tcg_date': instance.tcgDate,
      'set_image': instance.setImage,
    };
