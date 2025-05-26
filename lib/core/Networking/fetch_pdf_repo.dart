// filepath: c:\Users\PC\Desktop\Dirassati\lib\core\Networking\fetch_pdf_repo.dart
import 'dart:io';

import './fetch_pdf_api_service.dart';
import 'package:dirasati/core/Networking/api_result.dart';
import 'package:dirasati/core/Networking/api_error_handler.dart';

class FetchPdfRepo {
  final FetchPdfApiService _fetchPdfApiService;

  FetchPdfRepo(this._fetchPdfApiService);

  /// Fetches a PDF from the given [url] and saves it to [savePath].
  /// Returns [ApiResult<File>] to represent success or failure.
  Future<ApiResult<File>> fetchPdf(String url, String savePath) async {
    try {
      final file = await _fetchPdfApiService.fetchPdfByUrl(url, savePath);
      return ApiResult.success(file);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
