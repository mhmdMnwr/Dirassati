import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class PasswordsFieldsColumn extends StatelessWidget {
  TextEditingController currentPasswordController;
  TextEditingController newPasswordController;
  TextEditingController confirmPasswordController;
  PasswordsFieldsColumn({
    super.key,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextFormField(
          isObscureText: true,
          prefixIcon: Image.asset(
            IconsManager.changePassword,
            height: 40.h,
            width: 40.w,
            fit: BoxFit.contain,
          ),
          controller: currentPasswordController,
          hintText: 'Current Password',
          validator: _validateCurrentPassword,
        ),
        verticalSpace(20),
        AppTextFormField(
          isObscureText: true,
          prefixIcon: Image.asset(
            IconsManager.password,
          ),
          controller: newPasswordController,
          hintText: 'New Password',
          validator: _validateNewPassword,
        ),
        verticalSpace(20),
        AppTextFormField(
          isObscureText: true,
          prefixIcon: Image.asset(IconsManager.password),
          controller: confirmPasswordController,
          hintText: 'Confirm New Password',
          validator: _validateConfirmPassword,
        ),
        verticalSpace(32),
        Container()
      ],
    );
  }

  String? _validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Current password is required';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'New password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
