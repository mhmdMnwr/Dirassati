import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dirasati/features/marks/data/repo/marks_repo.dart';
import 'package:dirasati/features/marks/logic/cubit/marks_state.dart';
import 'package:dirasati/features/marks/data/model/years_model.dart';
import 'package:dirasati/features/marks/data/model/marks_model.dart';

class MarksCubit extends Cubit<MarksState> {
  // ignore: unused_field
  final MarksRepository _marksRepository;
  MarksCubit(this._marksRepository) : super(MarksState.initial());

  void getYears({required String studentId}) async {
    emit(MarksState.loading());
    
    // Adding delay to simulate network request
    await Future.delayed(const Duration(seconds: 1));
    
    // Dummy years data
    final dummyYears = [
      YearsModel(year: "2023/2024", trimestre: 1),
      YearsModel(year: "2023/2024", trimestre: 2),
      YearsModel(year: "2023/2024", trimestre: 3),
      YearsModel(year: "2022/2023", trimestre: 1),
      YearsModel(year: "2022/2023", trimestre: 2),
      YearsModel(year: "2022/2023", trimestre: 3),
    ];
    
    final dummyResponse = YearsResponse(
      success: true,
      statusCode: 200,
      data: dummyYears,
    );
    
    emit(MarksState.yearsloaded(dummyResponse));
    
    // Original implementation commented out for dummy data
    // final response = await _marksRepository.getStudentyears(studentId);
    // response.when(success: (yearsResponse) {
    //   emit(MarksState.yearsloaded(yearsResponse));
    // }, failure: (error) {
    //   emit(MarksState.error(error: error.apiErrorModel.message ?? ''));
    // });
  }

  void getMarks({required studentId, required year, required trimestre}) async {
    emit(MarksState.marksLoading());
    
    // Adding delay to simulate network request
    await Future.delayed(const Duration(seconds: 1));
    
    // Dummy marks data
    final dummyMarks = [
      MarksModel(
        subject: Subject(
          name: "الرياضيات",
          coefficient: 4,
          isMain: true,
          id: "math_001",
        ),
        nbOfAbsences: 2,
        noteCC: 16,
        firstTest: 15,
        secondTest: 17,
        exam: 18,
        id: "mark_001",
      ),
      MarksModel(
        subject: Subject(
          name: "اللغة العربية",
          coefficient: 4,
          isMain: true,
          id: "arabic_001",
        ),
        nbOfAbsences: 1,
        noteCC: 17,
        firstTest: 16,
        secondTest: 18,
        exam: 17,
        id: "mark_002",
      ),
      MarksModel(
        subject: Subject(
          name: "الفيزياء",
          coefficient: 3,
          isMain: true,
          id: "physics_001",
        ),
        nbOfAbsences: 0,
        noteCC: 15,
        firstTest: 14,
        secondTest: 16,
        exam: 16,
        id: "mark_003",
      ),
      MarksModel(
        subject: Subject(
          name: "الكيمياء",
          coefficient: 3,
          isMain: true,
          id: "chemistry_001",
        ),
        nbOfAbsences: 1,
        noteCC: 14,
        firstTest: 15,
        secondTest: 13,
        exam: 15,
        id: "mark_004",
      ),
      MarksModel(
        subject: Subject(
          name: "علوم الطبيعة والحياة",
          coefficient: 3,
          isMain: true,
          id: "biology_001",
        ),
        nbOfAbsences: 0,
        noteCC: 16,
        firstTest: 17,
        secondTest: 15,
        exam: 17,
        id: "mark_005",
      ),
      MarksModel(
        subject: Subject(
          name: "التاريخ والجغرافيا",
          coefficient: 2,
          isMain: false,
          id: "history_001",
        ),
        nbOfAbsences: 1,
        noteCC: 15,
        firstTest: 16,
        secondTest: 0, // No second test for non-main subjects
        exam: 14,
        id: "mark_006",
      ),
      MarksModel(
        subject: Subject(
          name: "الإنجليزية",
          coefficient: 2,
          isMain: false,
          id: "english_001",
        ),
        nbOfAbsences: 0,
        noteCC: 17,
        firstTest: 16,
        secondTest: 0, // No second test for non-main subjects
        exam: 18,
        id: "mark_007",
      ),
      MarksModel(
        subject: Subject(
          name: "الفرنسية",
          coefficient: 2,
          isMain: false,
          id: "french_001",
        ),
        nbOfAbsences: 2,
        noteCC: 13,
        firstTest: 14,
        secondTest: 0, // No second test for non-main subjects
        exam: 15,
        id: "mark_008",
      ),
      MarksModel(
        subject: Subject(
          name: "التربية الإسلامية",
          coefficient: 1,
          isMain: false,
          id: "islamic_001",
        ),
        nbOfAbsences: 0,
        noteCC: 18,
        firstTest: 17,
        secondTest: 0, // No second test for non-main subjects
        exam: 19,
        id: "mark_009",
      ),
      MarksModel(
        subject: Subject(
          name: "التربية البدنية",
          coefficient: 1,
          isMain: false,
          id: "sports_001",
        ),
        nbOfAbsences: 1,
        noteCC: 16,
        firstTest: 15,
        secondTest: 0, // No second test for non-main subjects
        exam: 17,
        id: "mark_010",
      ),
    ];
    
    final dummyResponse = GetMarksResponse(
      success: true,
      statusCode: 200,
      level: 1, // 1ere année secondaire
      data: dummyMarks,
    );
    
    emit(MarksState.marksLoaded(dummyResponse));
    
    // Original implementation commented out for dummy data
    // final validYear = year.replaceAll('/', '%2F');
    // final response =
    //     await _marksRepository.getStudentMarks(studentId, validYear, trimestre);
    // response.when(success: (marksResponse) {
    //   emit(MarksState.marksLoaded(marksResponse));
    // }, failure: (error) {
    //   emit(MarksState.marksError(error: error.apiErrorModel.message ?? ''));
    // });
  }
}
