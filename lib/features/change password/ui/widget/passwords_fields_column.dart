import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PasswordsFieldsColumn extends StatefulWidget {
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
  State<PasswordsFieldsColumn> createState() => _PasswordsFieldsColumnState();
}

class _PasswordsFieldsColumnState extends State<PasswordsFieldsColumn> {
  bool isNewPasswordObscureText = true;
  bool isCurrentPasswordObscureText = true;
  bool isConfirmPasswordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextFormField(
          suffixIcon: mySuffixIcon(
            isCurrentPasswordObscureText,
            () {
              setState(() {
                isCurrentPasswordObscureText = !isCurrentPasswordObscureText;
              });
            },
          ),
          isObscureText: isCurrentPasswordObscureText,
          prefixIcon: Image.asset(IconsManager.password_2),
          controller: widget.currentPasswordController,
          hintText: 'Current Password',
          validator: _validateCurrentPassword,
        ),
        verticalSpace(20),
        AppTextFormField(
          suffixIcon: mySuffixIcon(
            isNewPasswordObscureText,
            () {
              setState(() {
                isNewPasswordObscureText = !isNewPasswordObscureText;
              });
            },
          ),
          isObscureText: isNewPasswordObscureText,
          prefixIcon: Image.asset(IconsManager.password),
          controller: widget.newPasswordController,
          hintText: 'New Password',
          validator: _validateNewPassword,
        ),
        verticalSpace(20),
        AppTextFormField(
          suffixIcon: mySuffixIcon(
            isConfirmPasswordObscureText,
            () {
              setState(() {
                isConfirmPasswordObscureText = !isConfirmPasswordObscureText;
              });
            },
          ),
          isObscureText: isConfirmPasswordObscureText,
          prefixIcon: Image.asset(IconsManager.password),
          controller: widget.confirmPasswordController,
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
    if (value != widget.newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Widget mySuffixIcon(bool isObscureText, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isObscureText ? Icons.visibility_off : Icons.visibility,
      ),
    );
  }
}
