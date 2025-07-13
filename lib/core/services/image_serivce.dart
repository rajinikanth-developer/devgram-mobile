import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ImageService {
  static Future<String?> saveImagePermanently(File imageFile) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'img_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage = await imageFile.copy('${appDir.path}/$fileName');
      return savedImage.path;
    } catch (e) {
      return null;
    }
  }

  static Future<File?> getImageFile(String path) async {
    try {
      return File(path);
    } catch (e) {
      return null;
    }
  }
}
