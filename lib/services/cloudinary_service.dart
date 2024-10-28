// lib/services/cloudinary_service.dart
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class CloudinaryService {
  static late final CloudinaryPublic _cloudinary;
  
  static Future<void> initialize() async {
    await dotenv.load(); // Load .env file
    
    _cloudinary = CloudinaryPublic(
      dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '',
      dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? '',
      
      cache: false
    );
  }

  static Future<String?> uploadImage(File imageFile) async {
    try {
      CloudinaryResponse response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imageFile.path,
          folder: 'car_rentals',
        ),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      print('Cloudinary Error: ${e.message}');
      return null;
    } catch (e) {
      print('Upload Error: $e');
      return null;
    }
  }
}