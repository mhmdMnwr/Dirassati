import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
import 'package:dirasati/features/auth/ui/model_page.dart';
import 'package:dirasati/features/auth/ui/widgets/email_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelAuthPage(
      image: IconsManager.login,
      forgotPassword: true,
      pageName: 'LOG IN',
      nextRoute: Routes.homeScreen,
      formKey: _loginFormKey,
      buttonText: 'LOG IN',
      customField: EmailAndPassword(
        loginFormKey: _loginFormKey,
      ),
      emitTheState: context.read<LoginCubit>().emitLoginStates,
    );
  }
}
