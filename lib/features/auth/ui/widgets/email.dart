import 'package:dirasati/core/helpers/app_regulair_expression.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/widgets/app_text_form_field.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
import 'package:dirasati/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';

class EmailField extends StatefulWidget {
  final GlobalKey<FormState> forgetFormKey;
  const EmailField({super.key, required this.forgetFormKey});

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.forgetFormKey,
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
        ],
      ),
    );
  }
}
