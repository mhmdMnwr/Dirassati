import 'dart:io';

import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class ScheduleButton extends StatelessWidget {
  final String scheduleIcon;
  final String scheduleTitle;
  const ScheduleButton(
      {super.key, required this.scheduleIcon, required this.scheduleTitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ExamSchedulePopup.show(context);
      },
      child: Container(
        height: 77.h,
        width: 394.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(1, 3), // changes position of shadow
            ),
          ],
          color: ColorsManager.schedulLighterGray,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.asset(
              scheduleIcon,
              width: 50.w,
              height: 50.h,
            ),
            SizedBox(width: 45.w),
            Text(
              scheduleTitle,
              style: TextStyles.font22BlackBold,
            ),
          ]),
        ),
      ),
    );
  }
}

class ExamSchedulePopup {
  static Future<void> show(BuildContext context) async {
    // Load the PDF from assets to a temporary file (flutter_pdfview requires file path!)
    final file = await _loadPdfFromAssets('assets/1SC.pdf');

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                // Header
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    color: Colors.deepPurple,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Exam Schedule",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                // PDF Viewer
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20)),
                    child: PDFView(
                      filePath: file.path,
                      enableSwipe: true,
                      swipeHorizontal: false,
                      autoSpacing: true,
                      pageFling: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper to copy asset to temp folder
  static Future<File> _loadPdfFromAssets(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/exam_schedule.pdf');
    await tempFile.writeAsBytes(byteData.buffer.asUint8List(), flush: true);
    return tempFile;
  }
}
