import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:dirasati/features/justification/data/model/absence_response.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_cubit.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_state.dart';
import 'package:dirasati/features/justification/ui/justification_page.dart';
import 'package:dirasati/features/justification/ui/justification_wait_sent_page.dart';
import 'package:dirasati/features/justification/ui/nothing_to_justify_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsencePage extends StatelessWidget {
  final Student student;
  const AbsencePage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    if (student.isAbsent) {
      context.read<AbsenceCubit>().getStudentAbsence(studentId: student.id);
      return _buildBloc();
    } else {
      return NothingToJustifyPage();
    }
  }

  Widget _buildBloc() {
    return BlocBuilder<AbsenceCubit, AbsenceState>(
      buildWhen: (previous, current) =>
          current is Loading || current is Loaded || current is Error,
      builder: (context, state) {
        return state.whenOrNull(
              loading: () => setupLoading(),
              loaded: (absenceResponse) => setupLoaded(absenceResponse.data[0]),
              error: (error) => setupError(error),
              sending: () => setupSending(),
              sendSuccess: (standardata) => setupSendSuccess(standardata),
            ) ??
            SizedBox.shrink();
      },
    );
  }

  Widget setupLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: ColorsManager.mainBlue,
      ),
    );
  }

  Widget setupLoaded(AbsenceData absenceData) {
    if (absenceData.isJustified == false) {
      return JustificationPage(absenceData: absenceData);
    } else {
      return JustificationWaitSentPage(
        waitPage: false,
      );
    }
  }

  Widget setupError(String error) {
    return Center(
      child: Text(error),
    );
  }

  Widget setupSending() {
    return JustificationWaitSentPage(
      waitPage: true,
    );
  }

  Widget setupSendSuccess(standarData) {
    return JustificationWaitSentPage(
      waitPage: false,
    );
  }
}
