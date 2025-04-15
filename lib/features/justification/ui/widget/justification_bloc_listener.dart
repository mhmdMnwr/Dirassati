import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/features/justification/logic/cubit/justification_cubit.dart';
import 'package:dirasati/features/justification/logic/cubit/justification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildBlocListener extends StatefulWidget {
  const BuildBlocListener({super.key});

  @override
  State<BuildBlocListener> createState() => _BuildBlocListenerState();
}

class _BuildBlocListenerState extends State<BuildBlocListener> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<JustificationCubit, JustificationState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.mainBlue,
                ),
              ),
            );
          },
          success: (justificationResponse) {
            setState(() {});
          },
          error: (error) {
            context.pop();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                icon: const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 32,
                ),
                content: Text(error),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
