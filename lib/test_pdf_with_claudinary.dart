import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Upload and Display',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PdfUploaderAndViewer(),
    );
  }
}

class PdfUploaderAndViewer extends StatefulWidget {
  @override
  _PdfUploaderAndViewerState createState() => _PdfUploaderAndViewerState();
}

class _PdfUploaderAndViewerState extends State<PdfUploaderAndViewer> {
  final PdfService _apiService = PdfService();
  String? _uploadedPdfUrl;
  File? _fetchedPdfFile;
  bool _isLoading = false;

  Future<void> _pickAndUploadPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      setState(() => _isLoading = true);
      try {
        final uploadedUrl = await _apiService.uploadPdf(file);
        setState(() {
          _uploadedPdfUrl = uploadedUrl;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF uploaded successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload PDF: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _fetchAndDisplayPdf() async {
    if (_uploadedPdfUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No PDF URL available to fetch.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final fetchedFile = await _apiService.fetchPdf(_uploadedPdfUrl!);
      setState(() {
        _fetchedPdfFile = fetchedFile;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch PDF: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Upload and Display')),
      body: Column(
        children: [
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : _pickAndUploadPdf,
            child: Text('Pick and Upload PDF'),
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : _fetchAndDisplayPdf,
            child: Text('Fetch and Display PDF'),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          if (_fetchedPdfFile != null)
            Expanded(
              child: PDFView(
                filePath: _fetchedPdfFile!.path,
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: true,
                pageFling: true,
              ),
            ),
        ],
      ),
    );
  }
}

class PdfService {
  final Dio _dio;

  PdfService()
      : _dio = Dio()
          ..interceptors.add(LogInterceptor(
            request: true,
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            responseBody: true,
            error: true,
            logPrint: (obj) => debugPrint(obj.toString()),
          ));

  /// Uploads [file] as raw PDF using an **unsigned** preset that must allow raw resources.
  Future<String> uploadPdf(File file) async {
    const cloudinaryUrl =
        "https://api.cloudinary.com/v1_1/dzwjbf2dc/raw/upload";
    const uploadPreset =
        "dirassati"; // must be configured in Cloudinary to allow unsigned raw uploads

    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
      "upload_preset": uploadPreset,
      // REMOVE "access_mode": "public" because unsigned presets cannot accept it
    });

    final response = await _dio.post(cloudinaryUrl, data: formData);

    if (response.statusCode == 200) {
      final url = response.data["secure_url"] as String;
      debugPrint("✅ Uploaded PDF URL: $url");
      return url;
    } else {
      final err = response.data?["error"]?["message"] ?? response.statusMessage;
      throw Exception("Upload failed: $err");
    }
  }

  /// Fetches the PDF at [fileUrl] as bytes, writes it to a temp file, and returns it.
  Future<File> fetchPdf(String fileUrl) async {
    final response = await _dio.get<List<int>>(
      fileUrl,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: true,
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    debugPrint(
      "◀️ Fetch status: ${response.statusCode}, bytes: ${response.data?.length}",
    );

    if (response.statusCode == 200 &&
        response.data != null &&
        response.data!.isNotEmpty) {
      final directory = await getTemporaryDirectory();
      final filePath = path.join(directory.path, "fetched_pdf.pdf");
      final file = File(filePath);

      if (await file.exists()) {
        await file.delete();
      }

      await file.writeAsBytes(response.data!, flush: true);
      debugPrint("✅ PDF saved to: $filePath");
      return file;
    } else {
      throw Exception(
        "Fetch failed. Status: ${response.statusCode}, length: ${response.data?.length ?? 0}",
      );
    }
  }
}
