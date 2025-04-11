import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
import 'package:dirasati/features/auth/ui/model_page.dart';
import 'package:dirasati/features/auth/ui/widgets/email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> _forgetFormKey = GlobalKey<FormState>();
  ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelAuthPage(
      image: IconsManager.forgotPassword,
      pageName: '   Forgot \nPassword',
      nextRoute: Routes.otpScreen,
      formKey: _forgetFormKey,
      buttonText: 'Send Code',
      customField: EmailField(
        forgetFormKey: _forgetFormKey,
      ),
      emitTheState: context.read<LoginCubit>().emitForgetPasswordStates,
    );
  }
}
