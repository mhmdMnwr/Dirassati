import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/widgets/app_text_form_field.dart';
import 'package:dirasati/generated/app_localizations.dart';
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
          hintText: AppLocalizations.of(context)!.currentPassword,
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
          hintText: AppLocalizations.of(context)!.newPassword,
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
          hintText: AppLocalizations.of(context)!.confirmNewPassword,
          validator: _validateConfirmPassword,
        ),
        verticalSpace(32),
        Container()
      ],
    );
  }

  String? _validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.currentPasswordRequired;
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.newPasswordRequired;
    }
    if (value.length < 6) {
      return AppLocalizations.of(context)!.passwordMinSixCharacters;
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.confirmPasswordRequired;
    }
    if (value != widget.newPasswordController.text) {
      return AppLocalizations.of(context)!.passwordsDoNotMatch;
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
