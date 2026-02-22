import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bulk_box/src/features/backup/domain/entities/backup_card_data.dart';
import 'package:bulk_box/src/features/backup/domain/entities/backup_box_data.dart';
import 'package:bulk_box/src/features/backup/domain/entities/backup_item_data.dart';

part 'backup_manifest.freezed.dart';
part 'backup_manifest.g.dart';

@freezed
abstract class BackupManifest with _$BackupManifest {
  static const int currentVersion = 1;

  const factory BackupManifest({
    required int version,
    @JsonKey(name: 'schema_version') required int schemaVersion,
    @JsonKey(name: 'exported_at') required DateTime exportedAt,
    required List<BackupCardData> cards,
    required List<BackupBoxData> boxes,
    @JsonKey(name: 'unboxed_items') required List<BackupItemData> unboxedItems,
  }) = _BackupManifest;

  factory BackupManifest.fromJson(Map<String, dynamic> json) =>
      _$BackupManifestFromJson(json);
}
