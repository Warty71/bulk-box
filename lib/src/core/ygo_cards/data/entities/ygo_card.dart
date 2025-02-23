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
    required String setCode,
    required String setRarity,
    @Default(false) bool isLocalImageAvailable,
  }) = _YgoCard;

  factory YgoCard.fromJson(Map<String, dynamic> json) =>
      _$YgoCardFromJson(json);
}
