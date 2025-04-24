import 'dart:io';

import 'package:dirasati/core/di/dependency_injection.dart';
import 'package:dirasati/core/helpers/image_picker_helper.dart'; // Import the helper
import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/features/justification/data/model/absence_response.dart';
import 'package:dirasati/features/justification/data/repo/upload_images.dart';
import 'package:dirasati/features/justification/logic/cubit/upload_images_cubit.dart';
import 'package:dirasati/features/justification/ui/widget/build_add_photo_button.dart';
import 'package:dirasati/features/justification/ui/widget/build_image.dart'; // Import the new widget
import 'package:dirasati/features/justification/ui/widget/build_justification_title.dart';
import 'package:dirasati/features/justification/ui/widget/build_justify_button.dart';
import 'package:dirasati/features/justification/ui/widget/reason_of_absence_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JustificationPage extends StatefulWidget {
  final AbsenceData absenceData;
  const JustificationPage({super.key, required this.absenceData});

  @override
  State<JustificationPage> createState() => _JustificationPageState();
}

class _JustificationPageState extends State<JustificationPage> {
  late final TextEditingController _contentController;
  late final GlobalKey<FormState> reasonOfAbsenceKey = GlobalKey<FormState>();
  List<File> _imageFiles = []; // State variable remains
  static const int maxImageLimit = 4; // Define the image limit

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  // Function to remove an image (remains the same)
  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }

  // Function to handle adding photos using the helper, respecting the limit
  Future<void> _addPhotos() async {
    if (_imageFiles.length >= maxImageLimit) {
      // Show a message if the limit is already reached
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maximum $maxImageLimit images allowed.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final selectedFiles = await ImagePickerHelper.showImageSourceActionSheet(
      context,
      currentCount: _imageFiles.length,
      maxLimit: maxImageLimit,
    );

    if (selectedFiles.isNotEmpty) {
      int remainingSlots = maxImageLimit - _imageFiles.length;
      int filesToAddCount = selectedFiles.length;

      setState(() {
        if (filesToAddCount > remainingSlots) {
          // If more files were selected than available slots, take only allowed number
          _imageFiles.addAll(selectedFiles.take(remainingSlots));
          // Show a message indicating not all files were added
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Limit reached. Added $remainingSlots of $filesToAddCount selected images.'),
              backgroundColor: Colors.orange,
            ),
          );
        } else {
          // Add all selected files if within limit
          _imageFiles.addAll(selectedFiles);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _buildPageContent(context),
    );
  }

  // Extracted method for the main page container and layout
  Widget _buildPageContent(BuildContext context) {
    bool canAddMorePhotos = _imageFiles.length < maxImageLimit;
    return Container(
      margin: EdgeInsets.only(
        top: 80.h,
        left: 20.w,
        right: 20.w,
      ),
      constraints: BoxConstraints(
        maxHeight: 694.h,
      ),
      decoration: _buildContainerDecoration(),
      width: 350.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BuildJustificationTitle(
            subjectName: widget.absenceData.subjectName ?? 'Unknown Subject',
            absentSinceDate: widget.absenceData.absentSince,
          ),

          verticalSpace(20),
          ReasonOfAbsenceField(
            raeasonOfAbsenceKey: reasonOfAbsenceKey,
            controller: _contentController,
            hintText: 'reason of absence',
            onChanged: (value) {},
          ),
          verticalSpace(10),
          // Use the new ImagePreviewGrid widget
          ImagePreviewGrid(
            imageFiles: _imageFiles,
            onRemoveImage: _removeImage,
          ),

          BuildAddPhotoButton(
            onTap: _addPhotos,
            isEnabled: canAddMorePhotos,
          ),
          verticalSpace(15), // Added space for better separation
          BlocProvider(
            create: (context) =>
                UploadImagesCubit(getIt<ImageUploadRepository>()),
            child: BuildJustifyButton(
              reasonOfabsenceKey: reasonOfAbsenceKey,
              absenceId: widget.absenceData.id ?? '',
              content: _contentController,
              imageFiles: _imageFiles,
            ),
          ),
          verticalSpace(10), // Added bottom padding inside the container
        ],
      ),
    );
  }

  // Extracted method for container decoration
  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          // ignore: deprecated_member_use
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
      // ignore: deprecated_member_use
      color: ColorsManager.lightGray.withOpacity(0.3),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
