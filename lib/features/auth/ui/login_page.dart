import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
import 'package:dirasati/features/auth/ui/model_page.dart';
import 'package:dirasati/features/auth/ui/widgets/email_password.dart';
import 'package:dirasati/generated/app_localizations.dart';
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
      pageName: AppLocalizations.of(context)!.log_in,
      nextRoute: Routes.chooseSonScreen,
      formKey: _loginFormKey,
      buttonText: AppLocalizations.of(context)!.log_in,
      customField: EmailAndPassword(
        loginFormKey: _loginFormKey,
      ),
      emitTheState: context.read<LoginCubit>().emitLoginStates,
    );
  }
}
