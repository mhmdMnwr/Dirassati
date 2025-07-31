import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dirasati/features/HomeWork/data/repo/home_work_repo.dart';
import 'package:dirasati/features/HomeWork/logic/cubit/home_work_state.dart';
import 'package:dirasati/features/HomeWork/data/model/home_work_model.dart';

class HomeWorkCubit extends Cubit<HomeWorkState> {
  // ignore: unused_field
  final HomeWorkRepository _homeWorkRepository;

  HomeWorkCubit(this._homeWorkRepository) : super(HomeWorkState.initial());

  void getHomeWorkData({required String studentId}) async {
    emit(HomeWorkState.loading());

    // Adding delay to simulate network request
    await Future.delayed(const Duration(seconds: 1));

    // Dummy homework data
    final dummyHomeWorks = [
      HomeWorkModel(
        id: "1",
        subjectName: "الرياضيات",
        title: "حل المسائل الحسابية",
        description:
            "حل التمارين من صفحة 45 إلى 50 في كتاب الرياضيات، التركيز على عمليات الضرب والقسمة",
        attachments: ["math_exercises.pdf", "answer_sheet.pdf"],
        deadLine: DateTime.now().add(const Duration(days: 3)),
        status: "pending",
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      HomeWorkModel(
        id: "2",
        subjectName: "اللغة العربية",
        title: "قراءة وفهم النص",
        description:
            "قراءة النص في الصفحة 25 وكتابة ملخص لا يقل عن 100 كلمة، مع استخراج الكلمات الصعبة",
        attachments: ["arabic_text.pdf"],
        deadLine: DateTime.now().add(const Duration(days: 5)),
        status: "pending",
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      ),
      HomeWorkModel(
        id: "3",
        subjectName: "العلوم",
        title: "تجربة الماء والزيت",
        description:
            "إجراء تجربة لفصل الماء عن الزيت وكتابة تقرير مفصل عن النتائج المشاهدة",
        attachments: ["experiment_guide.pdf", "report_template.docx"],
        deadLine: DateTime.now().add(const Duration(days: 7)),
        status: "pending",
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      HomeWorkModel(
        id: "4",
        subjectName: "التاريخ",
        title: "بحث عن الحضارة الإسلامية",
        description:
            "كتابة بحث من 3 صفحات عن إنجازات الحضارة الإسلامية في العلوم والطب",
        attachments: [],
        deadLine: DateTime.now().add(const Duration(days: 10)),
        status: "pending",
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      ),
      HomeWorkModel(
        id: "5",
        subjectName: "الإنجليزية",
        title: "English Grammar Exercises",
        description:
            "Complete exercises 1-20 on page 35, focusing on present simple and present continuous tenses",
        attachments: ["grammar_book.pdf"],
        deadLine: DateTime.now().add(const Duration(days: 4)),
        status: "completed",
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];

    final dummyResponse = HomeWorkResponse(
      success: true,
      statusCode: 200,
      data: dummyHomeWorks,
    );

    emit(HomeWorkState.loaded(dummyResponse));

    // Original implementation commented out for dummy data
    // final response = await _homeWorkRepository.getHomeWork(studentId);
    // response.when(success: (homeWorkResponse) {
    //   emit(HomeWorkState.loaded(homeWorkResponse));
    // }, failure: (error) {
    //   emit(HomeWorkState.error(error: error.apiErrorModel.message ?? ''));
    // });
  }
}
