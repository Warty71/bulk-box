import 'package:freezed_annotation/freezed_annotation.dart';

part 'card.freezed.dart';
part 'card.g.dart';

@freezed
class Card with _$Card {
  const factory Card({
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
  }) = _Card;

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
}
