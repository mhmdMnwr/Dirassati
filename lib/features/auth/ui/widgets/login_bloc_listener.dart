import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/widgets/setup_bloc_states.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
import 'package:dirasati/features/auth/logic/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBlocListener extends StatelessWidget {
  final String newRoute;
  const LoginBlocListener({super.key, required this.newRoute});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            SetupLoadingState.show(context);
          },
          success: (loginResponse) {
            context.pop();
            context.pushReplacementNamed(newRoute);
          },
          error: (error) {
            context.pop();
            // context.pop();
            SetupErrorState.show(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
