import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ImageLocalDatasource {
  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/card_images';
  }

  Future<String> saveImage(int cardId, List<int> imageBytes) async {
    final path = await getLocalPath();
    final file = File('$path/$cardId.jpg');

    if (!await file.exists()) {
      await file.create(recursive: true);
    }

    await file.writeAsBytes(imageBytes);
    return file.path;
  }

  Future<bool> isImageSaved(int cardId) async {
    final path = await getLocalPath();
    return File('$path/$cardId.jpg').exists();
  }

  Future<String> getImagePath(int cardId) async {
    final path = await getLocalPath();
    return '$path/$cardId.jpg';
  }
}
