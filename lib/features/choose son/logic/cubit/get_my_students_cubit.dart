import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/features/choose%20son/data/model/get_me_response.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:dirasati/features/choose%20son/data/repo/get_my_studnets_repo.dart';
import 'package:dirasati/features/choose%20son/logic/cubit/get_my_students_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMyStudentsCubit extends Cubit<GetMyStudentsState> {
  // ignore: unused_field
  final GetMyStudentsRepo _getMyStudentsRepo;
  
  GetMyStudentsCubit(this._getMyStudentsRepo)
      : super(const GetMyStudentsState.initial());  void getMyStudents({required String parentId}) async {
    emit(const GetMyStudentsState.loading());
    
    // Add delay to simulate network request
    await Future.delayed(const Duration(seconds: 1));
    
    // Create dummy students data
    final dummyStudents = StudentsResponse(
      success: true,
      statusCode: 200,
      data: [
        Student(
          id: '1',
          firstName: 'أحمد', // Ahmed in Arabic
          lastName: 'محمد العلي', // Mohammed Al-Ali in Arabic
          email: 'ahmed@student.school',
          role: 'student',
          code: 'STD001',
          level: '1ere année secondaire', // 1st year secondary
          birthDate: DateTime(2007, 5, 15),
          inscriptionDate: DateTime(2022, 9, 1),
          gender: 'male',
          phone: '+966501234567',
          address: 'الرياض، السعودية', // Riyadh, Saudi Arabia
          isAbsent: false,
          classa: const Classa(
            planning: 'daily_schedule_1',
            examPlanning: 'exam_schedule_1',
          ),
        ),
        Student(
          id: '2',
          firstName: 'فاطمة', // Fatima in Arabic
          lastName: 'أحمد السالم', // Ahmed Al-Salem in Arabic
          email: 'fatima@student.school',
          role: 'student',
          code: 'STD002',
          level: '2eme année secondaire', // 2nd year secondary
          birthDate: DateTime(2006, 8, 22),
          inscriptionDate: DateTime(2021, 9, 1),
          gender: 'female',
          phone: '+966507654321',
          address: 'جدة، السعودية', // Jeddah, Saudi Arabia
          isAbsent: true,
          classa: const Classa(
            planning: 'daily_schedule_2',
            examPlanning: 'exam_schedule_2',
          ),
        ),
        Student(
          id: '3',
          firstName: 'يوسف', // Youssef in Arabic
          lastName: 'علي الأحمد', // Ali Al-Ahmed in Arabic
          email: 'youssef@student.school',
          role: 'student',
          code: 'STD003',
          level: '3eme année secondaire', // 3rd year secondary
          birthDate: DateTime(2005, 12, 10),
          inscriptionDate: DateTime(2020, 9, 1),
          gender: 'male',
          phone: '+966512345678',
          address: 'الدمام، السعودية', // Dammam, Saudi Arabia
          isAbsent: false,
          classa: const Classa(
            planning: 'daily_schedule_3',
            examPlanning: 'exam_schedule_3',
          ),
        ),
        Student(
          id: '2',
          firstName: 'محمد', // Mohammed in Arabic
          lastName: 'علي', // Ali in Arabic
          email: 'mohammed@student.school',
          role: 'student',
          code: 'STD002',
          level: 'primary',
          birthDate: DateTime(2013, 8, 22),
          inscriptionDate: DateTime(2020, 9, 1),
          gender: 'male',
          phone: '+966501234568',
          address: 'جدة، السعودية', // Jeddah, Saudi Arabia
          isAbsent: false,
          classa: const Classa(
            planning: 'daily_schedule_2',
            examPlanning: 'exam_schedule_2',
          ),
        ),
        Student(
          id: '3',
          firstName: 'فاطمة', // Fatima in Arabic
          lastName: 'حسن', // Hassan in Arabic
          email: 'fatima@student.school',
          role: 'student',
          code: 'STD003',
          level: 'middle',
          birthDate: DateTime(2011, 12, 10),
          inscriptionDate: DateTime(2018, 9, 1),
          gender: 'female',
          phone: '+966501234569',
          address: 'الدمام، السعودية', // Dammam, Saudi Arabia
          isAbsent: true,
          classa: const Classa(
            planning: 'daily_schedule_3',
            examPlanning: 'exam_schedule_3',
          ),
        ),
      ],
    );
    
    emit(GetMyStudentsState.success(dummyStudents));
    
    // Comment out the original API call
    /*
    final response = await _getMyStudentsRepo.getMyStudents(parentId);
    response.when(success: (studentsData) {
      emit(GetMyStudentsState.success(studentsData));
    }, failure: (error) {
      emit(GetMyStudentsState.error(error: error.apiErrorModel.message ?? ''));
    });
    */
  }

  void getMe() async {
    emit(const GetMyStudentsState.getMeloading());
    
    // Add delay to simulate network request
    await Future.delayed(const Duration(seconds: 1));
    
    // Create dummy parent data
    final dummyParentData = GetMeResponse(
      success: true,
      statusCode: 200,
      data: UserData(
        id: 'parent_123',
        firstName: 'أحمد', // Ahmed in Arabic
        lastName: 'محمد', // Mohammed in Arabic
        email: 'ahmed.mohammed@parent.com',
        role: 'parent',
        phone: '+966501234567',
        address: 'الرياض، السعودية', // Riyadh, Saudi Arabia
      ),
    );
    
    await saveParentId(dummyParentData.data.id!);
    emit(GetMyStudentsState.getMesuccess(dummyParentData));
    getMyStudents(
      parentId: dummyParentData.data.id!,
    );
    
    // Comment out the original API call
    /*
    final response = await _getMyStudentsRepo.getMe();
    response.when(success: (paretnData) async {
      await saveParentId(paretnData.data.id!);
      emit(GetMyStudentsState.getMesuccess(paretnData));
      getMyStudents(
        parentId: paretnData.data.id!,
      );
    }, failure: (error) {
      emit(GetMyStudentsState.getMeerror(
          error: error.apiErrorModel.message ?? ''));
    });
    */
  }

  Future<void> saveParentId(String parentId) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.parentId, parentId);
  }
}
