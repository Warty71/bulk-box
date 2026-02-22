import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bulk_box/src/features/backup/domain/entities/import_result.dart';

part 'backup_state.freezed.dart';

@freezed
abstract class BackupState with _$BackupState {
  const factory BackupState.initial() = _Initial;
  const factory BackupState.exporting() = _Exporting;
  const factory BackupState.exportSuccess(String filePath) = _ExportSuccess;
  const factory BackupState.importing() = _Importing;
  const factory BackupState.importSuccess(ImportResult result) = _ImportSuccess;
  const factory BackupState.error(String message) = _Error;
}
