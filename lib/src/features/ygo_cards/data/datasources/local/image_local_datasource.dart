import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ImageLocalDatasource {
  String? _cachedPath;

  Future<String> getLocalPath() async {
    if (_cachedPath != null) return _cachedPath!;

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/card_images';

    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    _cachedPath = path;
    return path;
  }

  Future<void> clearImageCache() async {
    final path = await getLocalPath();
    final directory = Directory(path);
    if (await directory.exists()) {
      await directory.delete(recursive: true);
      await directory.create();
    }
  }

  Future<String> saveImage(int cardId, List<int> imageBytes) async {
    if (!_isValidJpeg(imageBytes)) {
      throw Exception('Invalid JPEG data');
    }

    final path = await getLocalPath();
    final file = File('$path/$cardId.jpg');

    await file.writeAsBytes(imageBytes, flush: true);

    return file.path;
  }

  Future<bool> isImageSaved(int cardId) async {
    try {
      final path = await getLocalPath();
      final file = File('$path/$cardId.jpg');
      return await file.exists();
    } catch (_) {
      return false;
    }
  }

  Future<String> getImagePath(int cardId) async {
    final path = await getLocalPath();
    final filePath = '$path/$cardId.jpg';
    final file = File(filePath);

    if (!await file.exists()) {
      throw Exception('Image file not found');
    }

    return filePath;
  }

  bool _isValidJpeg(List<int> bytes) {
    if (bytes.length < 4) return false;

    return bytes[0] == 0xFF &&
        bytes[1] == 0xD8 &&
        bytes[bytes.length - 2] == 0xFF &&
        bytes[bytes.length - 1] == 0xD9;
  }
}
