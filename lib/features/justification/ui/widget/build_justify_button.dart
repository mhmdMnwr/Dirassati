import 'dart:io'; // Add this import

import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/justification/data/model/send_justification_request.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildJustifyButton extends StatefulWidget {
  final GlobalKey<FormState> reasonOfabsenceKey;
  final TextEditingController content;
  final String absenceId;
  final List<File>? imageFiles; // Change File? to List<File>?

  const BuildJustifyButton({
    super.key,
    required this.content,
    required this.absenceId,
    required this.reasonOfabsenceKey,
    this.imageFiles, // Update parameter
  });

  @override
  State<BuildJustifyButton> createState() => _BuildJustifyButtonState();
}

class _BuildJustifyButtonState extends State<BuildJustifyButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.reasonOfabsenceKey.currentState!.validate()) {
          // Handle image files if present
          if (widget.imageFiles != null && widget.imageFiles!.isNotEmpty) {
            debugPrint('Images selected: ${widget.imageFiles!.length}');
            // TODO: Implement multi-image upload logic here.
            // This will likely require modifying the AbsenceCubit and the API request
            // to handle multipart/form-data for multiple image uploads.
            // You might need to iterate through widget.imageFiles and add each
            // as a part to the multipart request.
          }

          // Existing justification sending logic
          context.read<AbsenceCubit>().sendJustification(
                sendJustificationRequest: SendJustificationRequest(
                  parent:
                      '${await SharedPrefHelper.getSecuredString(SharedPrefKeys.parentId)}',
                  absence: widget.absenceId,
                  content: widget.content.text,
                  // You'll need to adapt how images are sent in the request.
                  // Sending file paths in the JSON body is usually not sufficient.
                  // A common approach is using Dio's FormData for multipart requests.
                ),
              );
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 80.h,
        ),
        height: 66.h,
        width: 370.w,
        decoration: BoxDecoration(
          color: ColorsManager.skyBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Justify',
            style: TextStyles.font22Whitebold,
          ),
        ),
      ),
    );
  }
}
