import 'package:bulk_box/src/features/ygo_cards/domain/entities/card_set.dart';

class YgoCard {
  final int id;
  final String name;
  final String type;
  final String description;
  final String race;
  final String? frameType;
  final String? attribute;
  final int? level;
  final int? atk;
  final int? def;
  final String? archetype;
  final String imageUrl;
  final List<CardSet> cardSets;

  const YgoCard({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.race,
    this.frameType,
    this.attribute,
    this.level,
    this.atk,
    this.def,
    this.archetype,
    required this.imageUrl,
    required this.cardSets,
  });
}
