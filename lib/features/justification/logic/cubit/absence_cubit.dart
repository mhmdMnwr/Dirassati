import 'package:dirasati/features/justification/data/model/send_justification_request.dart';
import 'package:dirasati/features/justification/data/model/send_update_justification_request.dart';
import 'package:dirasati/features/justification/data/repo/steudent_absence_repo.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_state.dart';
import 'package:dirasati/features/justification/data/model/absence_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceCubit extends Cubit<AbsenceState> {
  // ignore: unused_field
  final GetStudentAbsenceRepo _getStudentAbsenceRepo;

  AbsenceCubit(
    this._getStudentAbsenceRepo,
  ) : super(const AbsenceState.initial());

  void getStudentAbsence({required String studentId}) async {
    emit(const AbsenceState.loading());
    
    // Adding delay to simulate network request
    await Future.delayed(const Duration(seconds: 1));
    
    // Dummy absence data - simulating a student with absences that need justification
    final dummyAbsenceData = AbsenceData(
      hasJustificationPending: false,
      id: "absence_001",
      subjectName: "الرياضيات",
      isJustified: false,
      absentSince: DateTime.now().subtract(const Duration(days: 2)),
      justification: null, // No justification yet, needs to be created
    );
    
    final dummyResponse = AbsenceResponse(
      success: true,
      statusCode: 200,
      data: dummyAbsenceData,
    );
    
    emit(AbsenceState.loaded(dummyResponse));
    
    // Original implementation commented out for dummy data
    // final response = await _getStudentAbsenceRepo.getStudentAbsence(studentId);
    // response.when(success: (absenceResponse) {
    //   emit(AbsenceState.loaded(absenceResponse));
    // }, failure: (error) {
    //   emit(AbsenceState.error(error: error.apiErrorModel.message ?? ''));
    // });
  }

  void sendJustification(
      {required SendJustificationRequest sendJustificationRequest}) async {
    emit(const AbsenceState.sending());
    
    // Adding delay to simulate network request
    await Future.delayed(const Duration(seconds: 2));
    
    // Dummy success response for sending justification
    final dummyResponse = AbsenceResponse(
      success: true,
      statusCode: 200,
      data: AbsenceData(
        hasJustificationPending: true,
        id: "absence_001",
        subjectName: "الرياضيات",
        isJustified: false,
        absentSince: DateTime.now().subtract(const Duration(days: 2)),
        justification: Justification(
          id: "justification_001",
          content: sendJustificationRequest.content,
          attachments: sendJustificationRequest.attachments,
        ),
      ),
    );
    
    emit(AbsenceState.sendSuccess(dummyResponse));
    
    // Original implementation commented out for dummy data
    // final response = await _getStudentAbsenceRepo
    //     .sendJustification(sendJustificationRequest);
    // response.when(success: (data) {
    //   emit(AbsenceState.sendSuccess(data));
    // }, failure: (error) {
    //   emit(AbsenceState.error(error: error.apiErrorModel.message ?? ''));
    // });
  }

  void updateJustification(
      {required String justificationId,
      required SendUpdateJustificationRequest
          sendUpdateJustificationRequest}) async {
    emit(const AbsenceState.sending());
    
    // Adding delay to simulate network request
    await Future.delayed(const Duration(seconds: 2));
    
    // Dummy success response for updating justification
    final dummyResponse = AbsenceResponse(
      success: true,
      statusCode: 200,
      data: AbsenceData(
        hasJustificationPending: true,
        id: "absence_001",
        subjectName: "الرياضيات",
        isJustified: false,
        absentSince: DateTime.now().subtract(const Duration(days: 2)),
        justification: Justification(
          id: justificationId,
          content: sendUpdateJustificationRequest.content,
          attachments: sendUpdateJustificationRequest.attachments,
        ),
      ),
    );
    
    emit(AbsenceState.sendSuccess(dummyResponse));
    
    // Original implementation commented out for dummy data
    // final response = await _getStudentAbsenceRepo.updateJustification(
    //     justificationId, sendUpdateJustificationRequest);
    // response.when(success: (data) {
    //   emit(AbsenceState.sendSuccess(data));
    // }, failure: (error) {
    //   emit(AbsenceState.error(error: error.apiErrorModel.message ?? ''));
    // });
  }
}
