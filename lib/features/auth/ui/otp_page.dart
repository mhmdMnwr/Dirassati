import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
import 'package:dirasati/features/auth/ui/model_page.dart';
import 'package:dirasati/features/auth/ui/widgets/otp_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpPage extends StatelessWidget {
  final GlobalKey<FormState> _verifyFormKey = GlobalKey<FormState>();
  OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelAuthPage(
      image: IconsManager.otpPage,
      pageName: 'Verification \n      Code',
      nextRoute: Routes.rsetPasswordScreen,
      formKey: _verifyFormKey,
      buttonText: 'Confirm',
      customField: OtpField(
        parentController: context.read<LoginCubit>().otpController,
        verifyFormKey: _verifyFormKey,
      ),
      emitTheState: context.read<LoginCubit>().emitVerifyOtpState,
    );
  }
}
