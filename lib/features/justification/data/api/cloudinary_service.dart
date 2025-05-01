import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageUploadApiService {
  final Dio dio = Dio();
  ImageUploadApiService() {
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
    ));
  }

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

  Future<File> fetchImageFile(String imageUrl) async {
    // 1) Use the full URL for downloading
    final response = await dio.get<List<int>>(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    final fileName = path.basename(imageUrl); // e.g. "myImage.heic"

    // 3) Build a valid local path
    final tempDir = await getTemporaryDirectory();
    final filePath = path.join(tempDir.path, fileName);

    // 4) Write and return
    final file = File(filePath);
    await file.writeAsBytes(response.data!);
    return file;
  }
}
