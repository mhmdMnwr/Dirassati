import 'dart:io';
import 'package:dio/dio.dart';

class ImageUploadApiService {
  final Dio dio = Dio();

  ImageUploadApiService();

  Future<String> uploadSingleImage(File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
      'upload_preset': 'dirassati',
    });

    final response = await dio.post(
      'https://api.cloudinary.com/v1_1/dzwjbf2dc/image/upload',
      data: formData,
    );

    return response.data['secure_url'];
  }
}
