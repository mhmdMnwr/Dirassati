import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/widgets/app_text_form_field.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
import 'package:dirasati/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';

class ResetPasswordField extends StatefulWidget {
  final GlobalKey<FormState> resetFormKey;
  const ResetPasswordField({super.key, required this.resetFormKey});

  @override
  State<ResetPasswordField> createState() => _ResetPasswordFieldState();
}

class _ResetPasswordFieldState extends State<ResetPasswordField> {
  bool isObscureText = true;
  bool isConfirmObscureText = true;

  late TextEditingController resetPasswordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    resetPasswordController =
        context.read<LoginCubit>().resetPasswordController;
    confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.resetFormKey,
      child: Column(
        children: [
          AppTextFormField(
            prefixIcon: Image.asset(
              IconsManager.password,
              width: 30.w,
              height: 30.h,
            ),
            controller: resetPasswordController,
            hintText: AppLocalizations.of(context)!.new_password,
            isObscureText: isObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              child: Icon(
                isObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value.isNullOrEmpty()) {
                return AppLocalizations.of(context)!.cannot_be_empty;
              }
              if (value!.length < 8) {
                return AppLocalizations.of(context)!.password_min_length;
              }
            },
          ),
          verticalSpace(18),
          AppTextFormField(
            prefixIcon: Image.asset(
              IconsManager.password,
              width: 30.w,
              height: 30.h,
            ),
            controller: confirmPasswordController,
            hintText: AppLocalizations.of(context)!.confirm_password,
            isObscureText: isConfirmObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isConfirmObscureText = !isConfirmObscureText;
                });
              },
              child: Icon(
                isConfirmObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.cannot_be_empty;
              } else if (value != resetPasswordController.text) {
                return AppLocalizations.of(context)!.passwords_do_not_match;
              }
            },
          ),
        ],
      ),
    );
  }
}
