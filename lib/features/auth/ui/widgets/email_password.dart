import 'package:dirasati/core/helpers/app_regulair_expression.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/widgets/app_text_form_field.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
import 'package:dirasati/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';

class EmailAndPassword extends StatefulWidget {
  final GlobalKey<FormState> loginFormKey;
  const EmailAndPassword({super.key, required this.loginFormKey});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObscureText = true;

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<LoginCubit>().passwordController;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.loginFormKey,
      child: Column(
        children: [
          AppTextFormField(
            prefixIcon: Image.asset(
              IconsManager.email,
              width: 30.w,
              height: 30.h,
            ),
            hintText: AppLocalizations.of(context)!.email,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return AppLocalizations.of(context)!.invalidEmail;
              }
            },
            controller: context.read<LoginCubit>().emailController,
          ),
          verticalSpace(18),
          AppTextFormField(
            prefixIcon: Image.asset(
              IconsManager.password,
              width: 30.w,
              height: 30.h,
            ),
            controller: context.read<LoginCubit>().passwordController,
            hintText: AppLocalizations.of(context)!.password,
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
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.cannotBeEmpty;
              }
            },
          ),
        ],
      ),
    );
  }
}
