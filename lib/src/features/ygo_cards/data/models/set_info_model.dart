// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/set_info.dart';

part 'set_info_model.freezed.dart';
part 'set_info_model.g.dart';

@freezed
abstract class SetInfoModel with _$SetInfoModel {
  const SetInfoModel._();

  const factory SetInfoModel({
    @JsonKey(name: 'set_name') required String setName,
    @JsonKey(name: 'set_code') required String setCode,
    @JsonKey(name: 'num_of_cards') required int numOfCards,
    @JsonKey(name: 'tcg_date') required String tcgDate,
    @JsonKey(name: 'set_image') String? setImage,
  }) = _SetInfoModel;

  factory SetInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SetInfoModelFromJson(json);

  SetInfo toEntity() => SetInfo(
        setName: setName,
        setCode: setCode,
        numOfCards: numOfCards,
        tcgDate: tcgDate,
        setImage: setImage,
      );
}
