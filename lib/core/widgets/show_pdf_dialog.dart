import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dirasati/core/Networking/fetch_pdf_cubit/cubit/fetch_pdf_cubit.dart';
import 'package:dirasati/core/Networking/fetch_pdf_repo.dart';
import 'package:dirasati/core/Networking/fetch_pdf_api_service.dart';

// Commenting out the ShowPdfDialog as per the request to show PDF directly.
// You can uncomment this if you need the dialog functionality later.

/*
class ShowPdfDialog extends StatefulWidget {
  final String pdfUrl;
  final String pdfName;
  final String? imageUrl;

  const ShowPdfDialog({
    Key? key,
    required this.pdfUrl,
    required this.pdfName,
    this.imageUrl,
  }) : super(key: key);

  @override
  State<ShowPdfDialog> createState() => _ShowPdfDialogState();
}

class _ShowPdfDialogState extends State<ShowPdfDialog> {
  late FetchPdfCubit _fetchPdfCubit;

  @override
  void initState() {
    super.initState();
    _fetchPdfCubit = FetchPdfCubit(FetchPdfRepo(FetchPdfApiService()));
  }

  @override
  Widget build(BuildContext context) {
    final String displayImageUrl =
        widget.imageUrl ?? 'assets/images/view_file.png';

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      titlePadding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0),
      contentPadding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0),
      actionsPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      title: Text(
        widget.pdfName,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width *
            0.8, // Constrain the width of the content
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.network(
                  displayImageUrl,
                  height: 180.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.picture_as_pdf_outlined,
                      size: 60.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      height: 180.h,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          strokeWidth: 3.w,
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 24.h),
              BlocProvider(
                create: (_) => _fetchPdfCubit,
                child: BlocConsumer<FetchPdfCubit, FetchPdfState>(
                  listener: (context, state) {
                    if (state is FetchPdfSuccess) {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => PdfViewerScreen(
                          pdfFile: state.pdfFile,
                          pdfName: widget.pdfName,
                        ),
                      ));
                    } else if (state is FetchPdfError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: ${state.error}'),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchPdfLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).colorScheme.primary),
                        ),
                      );
                    }
                    return ElevatedButton.icon(
                      icon: Icon(Icons.picture_as_pdf,
                          color: Colors.white, size: 20.sp),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () async {
                        final tempDir = Directory.systemTemp;
                        final savePath =
                            '${tempDir.path}/${widget.pdfName}.pdf';
                        _fetchPdfCubit.fetchPdf(widget.pdfUrl, savePath);
                      },
                      label: Text(
                        'عرض الملف',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            textStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('إغلاق'),
        ),
      ],
    );
  }
}
*/

// New Widget to directly load and show PDF
class DirectPdfLoaderScreen extends StatefulWidget {
  final String pdfUrl;
  final String pdfName;

  const DirectPdfLoaderScreen({
    Key? key,
    required this.pdfUrl,
    required this.pdfName,
  }) : super(key: key);

  @override
  State<DirectPdfLoaderScreen> createState() => _DirectPdfLoaderScreenState();
}

class _DirectPdfLoaderScreenState extends State<DirectPdfLoaderScreen> {
  late FetchPdfCubit _fetchPdfCubit;

  @override
  void initState() {
    super.initState();
    _fetchPdfCubit = FetchPdfCubit(FetchPdfRepo(FetchPdfApiService()));
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    // Ensure pdfName is a safe filename. You might want to sanitize it further.
    final sanitizedPdfName =
        widget.pdfName.replaceAll(RegExp(r'[^a-zA-Z0-9\.]'), '_');
    final tempDir = await Directory.systemTemp;
    final savePath = '${tempDir.path}/$sanitizedPdfName.pdf';
    _fetchPdfCubit.fetchPdf(widget.pdfUrl, savePath);
  }

  @override
  void dispose() {
    _fetchPdfCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _fetchPdfCubit,
      child: BlocListener<FetchPdfCubit, FetchPdfState>(
        listener: (context, state) {
          if (state is FetchPdfSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => PdfViewerScreen(
                pdfFile: state.pdfFile,
                pdfName: widget.pdfName,
              ),
            ));
          } else if (state is FetchPdfError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error loading PDF: ${state.error}'),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
              ),
            );
            // Pop the loader screen if an error occurs
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Loading ${widget.pdfName}...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.deepPurple,
          ),
          body: Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ),
    );
  }
}

// PdfViewerScreen remains the same
class PdfViewerScreen extends StatelessWidget {
  final File pdfFile;
  final String pdfName;

  const PdfViewerScreen({
    Key? key,
    required this.pdfFile,
    required this.pdfName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pdfName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(
          color: Colors
              .white, // Changed from Theme.of(context).colorScheme.onSurface
        ),
      ),
      body: SfPdfViewer.file(
        pdfFile,
        canShowScrollStatus: true,
        canShowScrollHead: true,
      ),
    );
  }
}
