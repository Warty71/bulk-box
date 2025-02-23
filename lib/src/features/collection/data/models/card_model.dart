// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_model.freezed.dart';
part 'card_model.g.dart';

@freezed
class CardModel with _$CardModel {
  const factory CardModel({
    required int id,
    required String name,
    required String type,
    required String desc,
    required String race,
    String? attribute,
    int? level,
    int? atk,
    int? def,
    @JsonKey(name: 'card_images') required List<CardImageModel> cardImages,
    @JsonKey(name: 'card_sets', defaultValue: [])
    required List<CardSetModel> cardSets,
  }) = _CardModel;

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

  static const fromJsonFactory = _$CardModelFromJson;
}

@freezed
class CardImageModel with _$CardImageModel {
  const factory CardImageModel({
    required int id,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'image_url_small') required String imageUrlSmall,
  }) = _CardImageModel;

  factory CardImageModel.fromJson(Map<String, dynamic> json) =>
      _$CardImageModelFromJson(json);
}

@freezed
class CardSetModel with _$CardSetModel {
  const factory CardSetModel({
    @JsonKey(name: 'set_name') required String setName,
    @JsonKey(name: 'set_code') required String setCode,
    @JsonKey(name: 'set_rarity') required String setRarity,
    @JsonKey(name: 'set_price') required String setPrice,
  }) = _CardSetModel;

  factory CardSetModel.fromJson(Map<String, dynamic> json) =>
      _$CardSetModelFromJson(json);
}
