import 'package:dirasati/core/widgets/setup_bloc_states.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:dirasati/features/justification/data/model/absence_response.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_cubit.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_state.dart';
import 'package:dirasati/features/justification/logic/cubit/upload_images_cubit.dart';
import 'package:dirasati/features/justification/logic/cubit/upload_images_state.dart';
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
    context.read<AbsenceCubit>().getStudentAbsence(studentId: student.id);
    return _buildBloc();
  }

  Widget _buildBloc() {
    return BlocBuilder<AbsenceCubit, AbsenceState>(
      buildWhen: (previous, current) =>
          current is Loading ||
          current is Loaded ||
          current is Error ||
          current is Sending ||
          current is SendSuccess,
      builder: (context, state) {
        return state.whenOrNull(
              loading: () => SetupLoadingState.build(),
              loaded: (absenceResponse) => setupLoaded(absenceResponse.data),
              error: (error) => setupError(error),
              sending: () => setupSending(),
              sendSuccess: (_) {
                setupSendSuccess(context);
                return SizedBox.shrink();
              },
            ) ??
            SizedBox.shrink();
      },
    );
  }

  Widget setupLoaded(absenceData) {
    if (absenceData == null) {
      return NothingToJustifyPage();
    }
    if (absenceData.hasJustificationPending == false) {
      return JustificationPage(absenceData: absenceData);
    } else {
      return _editJustificatioBlocBuilder(absenceData);
      //this line is for edit justification page
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

  void setupSendSuccess(BuildContext context) {
    context.read<AbsenceCubit>().getStudentAbsence(studentId: student.id);
  }

  _editJustificatioBlocBuilder(AbsenceData absenceData) {
    return BlocBuilder<UploadImagesCubit, UploadImagesState>(
      buildWhen: (previous, current) =>
          current is Edit ||
          current is FetchLoading ||
          current is FetchSuccess ||
          current is FetchError,
      builder: (context, state) {
        return state.whenOrNull(
              fetchLoading: () => SetupLoadingState.build(),
              edit: () => JustificationPage(
                absenceData: absenceData,
                isEditPage: true,
              ),
              fetchSuccess: (imageFiles) {
                return JustificationPage(
                  absenceData: absenceData,
                  isEditPage: true,
                  imageFiles: imageFiles,
                );
              },
              fetchError: (error) {
                SetupErrorState.show(context, error);
                return SizedBox.shrink();
              },
            ) ??
            JustificationWaitSentPage(
              absenceData: absenceData,
              waitPage: false,
            );
      },
    );
  }
}
