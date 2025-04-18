import 'dart:io';
import 'package:dirasati/core/helpers/spacing.dart';
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
      onTap: () => ExamSchedulePopup.show(context, scheduleTitle),
      child: Container(
        height: 77.h,
        width: 394.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(1, 3),
            ),
          ],
          color: ColorsManager.schedulLighterGray,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Row(children: [
            Image.asset(scheduleIcon, width: 50.w, height: 50.h),
            verticalSpace(45),
            Text(scheduleTitle, style: TextStyles.font22BlackBold),
          ]),
        ),
      ),
    );
  }
}

class ExamSchedulePopup {
  final String scheduleTitle;
  ExamSchedulePopup({required this.scheduleTitle});
  static Future<void> show(BuildContext context, String scheduleTitle) async {
    final file = await _loadPdfFromAssets('assets/1SC.pdf');

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            children: [
              // Header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(scheduleTitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // PDF Viewer
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: PDFView(
                      filePath: file.path,
                      enableSwipe: true,
                      swipeHorizontal: false,
                      autoSpacing: true,
                      pageFling: true,
                      fitPolicy: FitPolicy.WIDTH,
                      defaultPage: 0,
                      pageSnap: true,
                      nightMode: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<File> _loadPdfFromAssets(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/exam_schedule.pdf');
    await tempFile.writeAsBytes(byteData.buffer.asUint8List(), flush: true);
    return tempFile;
  }
}
