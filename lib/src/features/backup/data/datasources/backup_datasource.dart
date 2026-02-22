import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:bulk_box/src/features/backup/domain/entities/backup_manifest.dart';

class BackupDatasource {
  Future<String> writeToFile(BackupManifest manifest) async {
    final tempDir = await getTemporaryDirectory();
    final now = DateTime.now();
    final y = now.year.toString().padLeft(4, '0');
    final mo = now.month.toString().padLeft(2, '0');
    final d = now.day.toString().padLeft(2, '0');
    final h = now.hour.toString().padLeft(2, '0');
    final mi = now.minute.toString().padLeft(2, '0');
    final s = now.second.toString().padLeft(2, '0');
    final timestamp = '$y$mo${d}_$h$mi$s';
    final file = File('${tempDir.path}/bulk_box_backup_$timestamp.bulkbox');
    final json = jsonEncode(manifest.toJson());
    await file.writeAsString(json, encoding: utf8);
    return file.path;
  }

  Future<BackupManifest> readFromFile(String filePath) async {
    final file = File(filePath);
    final content = await file.readAsString(encoding: utf8);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return BackupManifest.fromJson(json);
  }
}
