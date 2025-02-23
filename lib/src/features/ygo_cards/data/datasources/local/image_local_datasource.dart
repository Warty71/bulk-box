import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ImageLocalDatasource {
  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/card_images';

    // Ensure directory exists
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

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
    try {
      // Validate image data
      if (!_isValidJpeg(imageBytes)) {
        throw Exception('Invalid JPEG data');
      }

      final path = await getLocalPath();
      final file = File('$path/$cardId.jpg');

      // Delete existing file if it exists
      if (await file.exists()) {
        await file.delete();
      }

      // Create new file and write bytes
      await file.create(recursive: true);
      await file.writeAsBytes(imageBytes, flush: true);

      // Verify the file was written correctly
      final savedBytes = await file.readAsBytes();
      if (!_isValidJpeg(savedBytes)) {
        await file.delete();
        throw Exception('Saved file is not a valid JPEG');
      }

      return file.path;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isImageSaved(int cardId) async {
    try {
      final path = await getLocalPath();
      final file = File('$path/$cardId.jpg');

      if (!await file.exists()) {
        return false;
      }

      // Read and validate the file
      final bytes = await file.readAsBytes();
      if (!_isValidJpeg(bytes)) {
        await file.delete();
        return false;
      }

      return true;
    } catch (e) {
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

    // Validate the file
    final bytes = await file.readAsBytes();
    if (!_isValidJpeg(bytes)) {
      await file.delete();
      throw Exception('Invalid image file');
    }

    return filePath;
  }

  bool _isValidJpeg(List<int> bytes) {
    if (bytes.length < 4) return false;

    // Check JPEG magic numbers
    return bytes[0] == 0xFF &&
        bytes[1] == 0xD8 && // JPEG start marker
        bytes[bytes.length - 2] == 0xFF &&
        bytes[bytes.length - 1] == 0xD9; // JPEG end marker
  }
}
