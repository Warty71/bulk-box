import 'package:bulk_box/src/features/backup/domain/entities/backup_manifest.dart';
import 'package:bulk_box/src/features/backup/domain/entities/import_result.dart';

abstract class BackupRepository {
  Future<String> exportCollection();
  Future<BackupManifest> parseBackupFile(String filePath);
  Future<ImportResult> importCollection(
    BackupManifest manifest, {
    required bool merge,
  });
}
