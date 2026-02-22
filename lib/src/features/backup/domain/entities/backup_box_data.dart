import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bulk_box/src/features/backup/domain/entities/backup_item_data.dart';

part 'backup_box_data.freezed.dart';
part 'backup_box_data.g.dart';

@freezed
abstract class BackupBoxData with _$BackupBoxData {
  const factory BackupBoxData({
    required String name,
    String? color,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    required List<BackupItemData> items,
  }) = _BackupBoxData;

  factory BackupBoxData.fromJson(Map<String, dynamic> json) =>
      _$BackupBoxDataFromJson(json);
}
