import 'dart:io';
import 'package:dirasati/core/Networking/api_error_handler.dart';
import 'package:dirasati/core/Networking/api_result.dart';
import 'package:dirasati/features/justification/data/api/cloudinary_service.dart';

class ImageUploadRepository {
  final ImageUploadApiService api;

  ImageUploadRepository(this.api);

  Future<ApiResult<List<String>>> uploadImages(List<File> files) async {
    List<String> urls = [];

    for (final file in files) {
      try {
        final url = await api.uploadSingleImage(file);
        urls.add(url);
      } catch (error) {
        ApiResult.failure(ErrorHandler.handle(error));
        // Handle the error as needed, e.g., log it or show a message to the user
      }
    }

    return ApiResult.success(urls);
  }

  Future<ApiResult<List<File>>> fetchImageFile(List<String> imageName) async {
    final List<File> files = [];
    try {
      for (final name in imageName) {
        final file = await api.fetchImageFile(name);
        files.add(file);
      }

      return ApiResult.success(files);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
