import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dirasati/core/di/dependency_injection.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

class FetchPdfApiService {
  final Dio _dio = getIt<Dio>();

  /// Downloads a PDF from the given [url] and saves it to [savePath].
  /// Returns the saved file.
  Future<File> fetchPdfByUrl(String url, String savePath) async {
    try {
      // Fetch the PDF as a list of bytes
      final response = await _dio.get<List<int>>(
        url,
        options: Options(
          responseType: ResponseType.bytes, // Important to get raw bytes
          followRedirects: true, // Usually good for fetching files
          validateStatus: (status) =>
              status != null && status < 500, // Standard validation
        ),
      );

      debugPrint(
        "◀️ PDF Fetch status: ${response.statusCode}, bytes: ${response.data?.length}",
      );

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data!.isNotEmpty) {
        final file = File(savePath);

        // Ensure directory exists (optional, as writeAsBytes might create it, but good practice)
        final directory = Directory(file.parent.path);
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        // Delete the file if it already exists to avoid appending or errors
        if (await file.exists()) {
          await file.delete();
        }

        // Write the bytes to the file
        await file.writeAsBytes(response.data!, flush: true);
        debugPrint("✅ PDF saved to: $savePath");
        return file;
      } else {
        throw Exception(
          'Failed to download PDF. Status: ${response.statusCode}, Data length: ${response.data?.length ?? 0}',
        );
      }
    } catch (e) {
      // Catch DioException specifically if you want to handle Dio-related errors differently
      if (e is DioException) {
        debugPrint('DioException downloading PDF: ${e.message}');
        throw Exception('Error downloading PDF (DioException): ${e.message}');
      }
      debugPrint('Error downloading PDF: $e');
      throw Exception('Error downloading PDF: $e');
    }
  }
}
