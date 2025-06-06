import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
import 'package:dirasati/features/auth/ui/model_page.dart';
import 'package:dirasati/features/auth/ui/widgets/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> _resetFormKey = GlobalKey<FormState>();
  ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelAuthPage(
      image: IconsManager.resetpassword,
      pageName: '   Reset \nPassword',
      nextRoute: Routes.loginScreen,
      formKey: _resetFormKey,
      buttonText: 'Confirm',
      customField: ResetPasswordField(
        resetFormKey: _resetFormKey,
      ),
      emitTheState: context.read<LoginCubit>().emitResetPasswordState,
    );
  }
}
