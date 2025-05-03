import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryService {
  static final CloudinaryService _instance = CloudinaryService._internal();
  late CloudinaryPublic _cloudinary;

  // Private constructor
  CloudinaryService._internal() {
    final cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
    final uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? '';
    _cloudinary = CloudinaryPublic(cloudName, uploadPreset);
  }

  // Factory constructor to return the same instance
  factory CloudinaryService() {
    return _instance;
  }

  /// Uploads an image to Cloudinary and returns the secure URL
  Future<String?> uploadImage(File imageFile) async {
    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imageFile.path,
          folder: 'rent_cars',
        ),
      );
      return response.secureUrl;
    } catch (e) {
      print('Error uploading to Cloudinary: $e');
      return null;
    }
  }
}
