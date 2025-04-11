import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/widgets/app_text_form_field.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
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
            hintText: 'New Password',
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
                return 'Please enter a valid password';
              }
              if (value!.length < 8) {
                return 'Password must be at least 8 characters';
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
            hintText: 'Confirm Password',
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
                return 'Please enter a valid password';
              } else if (value != resetPasswordController.text) {
                return 'Password does not match';
              }
            },
          ),
        ],
      ),
    );
  }
}
