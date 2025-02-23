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
    required List<CardImageModel> cardImages,
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
    required String imageUrl,
    required String imageUrlSmall,
  }) = _CardImageModel;

  factory CardImageModel.fromJson(Map<String, dynamic> json) =>
      _$CardImageModelFromJson(json);
}

@freezed
class CardSetModel with _$CardSetModel {
  const factory CardSetModel({
    required String setName,
    required String setCode,
    required String setRarity,
    required String setPrice,
  }) = _CardSetModel;

  factory CardSetModel.fromJson(Map<String, dynamic> json) =>
      _$CardSetModelFromJson(json);
}
