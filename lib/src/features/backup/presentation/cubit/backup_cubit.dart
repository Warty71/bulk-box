import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:bulk_box/src/features/backup/domain/entities/backup_manifest.dart';
import 'package:bulk_box/src/features/backup/domain/repositories/backup_repository.dart';
import 'package:bulk_box/src/features/backup/presentation/cubit/backup_state.dart';
import 'package:bulk_box/src/features/backup/presentation/cubit/import_mode.dart';
import 'package:bulk_box/src/features/backup/presentation/widgets/import_options_dialog.dart';

class BackupCubit extends Cubit<BackupState> {
  final BackupRepository _repository;

  BackupCubit(this._repository) : super(const BackupState.initial());

  Future<void> export({Rect? sharePositionOrigin}) async {
    emit(const BackupState.exporting());
    try {
      final filePath = await _repository.exportCollection();
      await Share.shareXFiles(
        [XFile(filePath)],
        sharePositionOrigin: sharePositionOrigin,
      );
      emit(BackupState.exportSuccess(filePath));
    } catch (e) {
      emit(BackupState.error('Export failed: $e'));
    }
  }

  /// DEBUG: simulates the importing state for 5 seconds.
  Future<void> debugSimulateImport() async {
    emit(const BackupState.importing());
    await Future.delayed(const Duration(seconds: 5));
    emit(const BackupState.initial());
  }

  Future<void> pickAndImport(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result == null || result.files.isEmpty) return;
    final filePath = result.files.single.path;
    if (filePath == null) return;

    final BackupManifest manifest;
    try {
      manifest = await _repository.parseBackupFile(filePath);
    } catch (e) {
      emit(BackupState.error('Could not read backup file: $e'));
      return;
    }

    // ignore: use_build_context_synchronously
    if (!context.mounted) return;
    final mode = await ImportOptionsDialog.show(context);
    if (mode == null) return;

    emit(const BackupState.importing());
    try {
      final importResult = await _repository.importCollection(
        manifest,
        merge: mode == ImportMode.merge,
      );
      emit(BackupState.importSuccess(importResult));
    } catch (e) {
      emit(BackupState.error('Import failed: $e'));
    }
  }
}
