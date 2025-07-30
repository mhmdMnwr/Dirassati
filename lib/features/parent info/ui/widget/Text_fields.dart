import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/widgets/app_text_form_field.dart';
import 'package:dirasati/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class TextFieldsColumn extends StatelessWidget {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextFieldsColumn({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.addressController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          prefixIcon: Image.asset(IconsManager.name),
          controller: firstNameController,
          hintText: AppLocalizations.of(context)!.first_name,
          validator: (value) => _validateName(value, context),
        ),
        verticalSpace(16.h),

        // Last Name
        AppTextFormField(
          prefixIcon: Image.asset(IconsManager.name),
          controller: lastNameController,
          hintText: AppLocalizations.of(context)!.last_name,
          validator: (value) => _validateName(value, context),
        ),
        verticalSpace(16.h),

        // Address
        AppTextFormField(
          prefixIcon: Image.asset(
            IconsManager.address,
            height: 30.h,
            width: 30.w,
          ),
          controller: addressController,
          hintText: AppLocalizations.of(context)!.address,
          validator: (value) => _validateAddress(value, context),
        ),
        verticalSpace(16.h),

        // Phone
        AppTextFormField(
          prefixIcon: Image.asset(
            IconsManager.phone,
            height: 30.h,
            width: 30.w,
          ),
          controller: phoneController,
          hintText: AppLocalizations.of(context)!.phone,
          digitOnly: true,
          validator: (value) => _validatePhone(value, context),
        ),
        verticalSpace(32),
      ],
    );
  }

  String? _validateName(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty)
      return AppLocalizations.of(context)!.cannot_be_empty;
    if (value.trim().length < 2) return 'At least 2 characters';
    if (value.trim().length > 25) return 'Max 25 characters';
    return null;
  }

  String? _validateAddress(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty)
      return AppLocalizations.of(context)!.cannot_be_empty;
    if (value.trim().length > 50) return 'Max 50 characters';
    return null;
  }

  String? _validatePhone(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty)
      return AppLocalizations.of(context)!.cannot_be_empty;

    return null;
  }
}
