// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_info_model.freezed.dart';
part 'set_info_model.g.dart';

@freezed
abstract class SetInfoModel with _$SetInfoModel {
  const factory SetInfoModel({
    @JsonKey(name: 'set_name') required String setName,
    @JsonKey(name: 'set_code') required String setCode,
    @JsonKey(name: 'num_of_cards') required int numOfCards,
    @JsonKey(name: 'tcg_date') required String tcgDate,
    @JsonKey(name: 'set_image') String? setImage,
  }) = _SetInfoModel;

  factory SetInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SetInfoModelFromJson(json);
}
