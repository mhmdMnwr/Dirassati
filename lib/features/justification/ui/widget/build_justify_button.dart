import 'dart:io'; // Add this import

import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/core/widgets/setup_bloc_states.dart';
import 'package:dirasati/features/justification/data/model/send_justification_request.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_cubit.dart';
import 'package:dirasati/features/justification/logic/cubit/upload_images_cubit.dart';
import 'package:dirasati/features/justification/logic/cubit/upload_images_state.dart';
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
    return BlocListener<UploadImagesCubit, UploadImagesState>(
      listenWhen: (previous, current) =>
          current is UploadLoading ||
          current is UploadSuccess ||
          current is UploadError,
      listener: (context, state) {
        state.whenOrNull(
          uploadLoading: () => SetupLoadingState.show(context),
          uploadSuccess: (imagesUrlList) async {
            Navigator.pop(context); // Close the loading dialog
            context.read<AbsenceCubit>().sendJustification(
                  sendJustificationRequest: SendJustificationRequest(
                    attachments: imagesUrlList,
                    parent:
                        '${await SharedPrefHelper.getSecuredString(SharedPrefKeys.parentId)}',
                    absence: widget.absenceId,
                    content: widget.content.text,
                  ),
                );
          },
          uploadError: (error) {
            SetupErrorState.show(context, error);
          },
        );
      },
      child: GestureDetector(
        onTap: () async {
          if (widget.reasonOfabsenceKey.currentState!.validate()) {
            // Handle image files if present
            if (widget.imageFiles != null && widget.imageFiles!.isNotEmpty) {
              context
                  .read<UploadImagesCubit>()
                  .uploadImages(widget.imageFiles!);
            } else {
              // If no images, directly send justification
              context.read<AbsenceCubit>().sendJustification(
                    sendJustificationRequest: SendJustificationRequest(
                      attachments: [], // No images to attach
                      parent:
                          '${await SharedPrefHelper.getSecuredString(SharedPrefKeys.parentId)}',
                      absence: widget.absenceId,
                      content: widget.content.text,
                    ),
                  );
            }
          }
        },
        child: Container(
          margin: EdgeInsets.only(
            top: 90.h,
          ),
          height: 66.h,
          width: 370.w,
          decoration: BoxDecoration(
            color: ColorsManager.skyBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Submit',
              style: TextStyles.font22Whitebold,
            ),
          ),
        ),
      ),
    );
  }
}
