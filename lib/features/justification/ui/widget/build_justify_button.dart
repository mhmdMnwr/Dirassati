import 'dart:io'; // Add this import

import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/core/widgets/setup_bloc_states.dart';
import 'package:dirasati/features/justification/data/model/send_justification_request.dart';
import 'package:dirasati/features/justification/data/model/send_update_justification_request.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_cubit.dart';
import 'package:dirasati/features/justification/logic/cubit/upload_images_cubit.dart';
import 'package:dirasati/features/justification/logic/cubit/upload_images_state.dart';
import 'package:dirasati/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildJustifyButton extends StatefulWidget {
  final String justificationId;
  final GlobalKey<FormState> reasonOfabsenceKey;
  final bool isEdit;
  final TextEditingController content;
  final String absenceId;
  final List<File>? imageFiles; // Change File? to List<File>?

  const BuildJustifyButton({
    super.key,
    this.justificationId = '',
    this.isEdit = false,
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
            _sendjustificationWithImages(
              widget.isEdit,
              imagesUrlList,
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
            if (widget.imageFiles != null && widget.imageFiles!.isNotEmpty) {
              _uploadImages(widget.imageFiles!);
            } else {
              // If no images, directly send justification
              _sendJustificationWitoutImages(widget.isEdit);
            }
            context.read<UploadImagesCubit>().eliminateState();
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
              widget.isEdit
                  ? AppLocalizations.of(context)!.edit
                  : AppLocalizations.of(context)!.submit,
              style: TextStyles.font22Whitebold,
            ),
          ),
        ),
      ),
    );
  }

  void _sendJustificationWitoutImages(bool isEdit) async {
    if (isEdit) {
      context.read<AbsenceCubit>().updateJustification(
            justificationId: widget.justificationId,
            sendUpdateJustificationRequest: SendUpdateJustificationRequest(
              parent:
                  '${await SharedPrefHelper.getSecuredString(SharedPrefKeys.parentId)}',
              attachments: [],
              content: widget.content.text,
            ),
          );
    } else {
      context.read<AbsenceCubit>().sendJustification(
            sendJustificationRequest: SendJustificationRequest(
              attachments: [],
              parent:
                  '${await SharedPrefHelper.getSecuredString(SharedPrefKeys.parentId)}',
              absence: widget.absenceId,
              content: widget.content.text,
            ),
          );
    }
  }

  void _uploadImages(List<File> imageFiles) {
    context.read<UploadImagesCubit>().uploadImages(imageFiles);
  }

  void _sendjustificationWithImages(bool isEdit, List<String> images) async {
    if (isEdit) {
      context.read<AbsenceCubit>().updateJustification(
            justificationId: widget.justificationId,
            sendUpdateJustificationRequest: SendUpdateJustificationRequest(
              parent:
                  '${await SharedPrefHelper.getSecuredString(SharedPrefKeys.parentId)}',
              attachments: images,
              content: widget.content.text,
            ),
          );
    } else {
      context.read<AbsenceCubit>().sendJustification(
            sendJustificationRequest: SendJustificationRequest(
              attachments: images,
              parent:
                  '${await SharedPrefHelper.getSecuredString(SharedPrefKeys.parentId)}',
              absence: widget.absenceId,
              content: widget.content.text,
            ),
          );
    }
  }
}
