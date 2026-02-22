import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bulk_box/src/features/backup/domain/entities/backup_card_set_data.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/card_set.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';

part 'backup_card_data.freezed.dart';
part 'backup_card_data.g.dart';

@freezed
abstract class BackupCardData with _$BackupCardData {
  const BackupCardData._();

  const factory BackupCardData({
    required int id,
    required String name,
    required String type,
    required String description,
    required String race,
    @JsonKey(name: 'frame_type') String? frameType,
    String? attribute,
    int? level,
    int? atk,
    int? def,
    String? archetype,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'card_sets') required List<BackupCardSetData> cardSets,
  }) = _BackupCardData;

  factory BackupCardData.fromJson(Map<String, dynamic> json) =>
      _$BackupCardDataFromJson(json);

  factory BackupCardData.fromYgoCard(YgoCard card) => BackupCardData(
        id: card.id,
        name: card.name,
        type: card.type,
        description: card.description,
        race: card.race,
        frameType: card.frameType,
        attribute: card.attribute,
        level: card.level,
        atk: card.atk,
        def: card.def,
        archetype: card.archetype,
        imageUrl: card.imageUrl,
        cardSets: card.cardSets
            .map(
              (s) => BackupCardSetData(
                setName: s.setName,
                setCode: s.setCode,
                setRarity: s.setRarity,
                setEdition: s.setEdition,
                setPrice: s.setPrice,
                setPriceLow: s.setPriceLow,
                setUrl: s.setUrl,
              ),
            )
            .toList(),
      );

  YgoCard toYgoCard() => YgoCard(
        id: id,
        name: name,
        type: type,
        description: description,
        race: race,
        frameType: frameType,
        attribute: attribute,
        level: level,
        atk: atk,
        def: def,
        archetype: archetype,
        imageUrl: imageUrl,
        cardSets: cardSets
            .map(
              (s) => CardSet(
                setName: s.setName,
                setCode: s.setCode,
                setRarity: s.setRarity,
                setEdition: s.setEdition,
                setPrice: s.setPrice,
                setPriceLow: s.setPriceLow,
                setUrl: s.setUrl,
              ),
            )
            .toList(),
      );
}
