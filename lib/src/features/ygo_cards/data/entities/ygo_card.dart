import 'package:freezed_annotation/freezed_annotation.dart';

part 'ygo_card.freezed.dart';
part 'ygo_card.g.dart';

@freezed
class YgoCard with _$YgoCard {
  const factory YgoCard({
    required int id,
    required String name,
    required String type,
    required String description,
    required String race,
    String? attribute,
    int? level,
    int? atk,
    int? def,
    required String imageUrl,
    required List<CardSet> cardSets,
    @Default(false) bool isLocalImageAvailable,
  }) = _YgoCard;

  factory YgoCard.fromJson(Map<String, dynamic> json) =>
      _$YgoCardFromJson(json);
}

@freezed
class CardSet with _$CardSet {
  const factory CardSet({
    required String setName,
    required String setCode,
    required String setRarity,
    required String setPrice,
  }) = _CardSet;

  factory CardSet.fromJson(Map<String, dynamic> json) =>
      _$CardSetFromJson(json);
}
