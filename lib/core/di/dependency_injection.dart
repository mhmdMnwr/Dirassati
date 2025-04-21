import 'package:dio/dio.dart';
import 'package:dirasati/core/Networking/api_service.dart';
import 'package:dirasati/core/Networking/dio_factory.dart';
import 'package:dirasati/features/auth/data/repo/login_repo.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
import 'package:dirasati/features/choose%20son/data/repo/get_my_studnets_repo.dart';
import 'package:dirasati/features/choose%20son/logic/cubit/get_my_students_cubit.dart';
import 'package:dirasati/features/justification/data/repo/steudent_absence_repo.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  getIt.registerLazySingleton<GetMyStudentsRepo>(
      () => GetMyStudentsRepo(getIt()));
  getIt.registerLazySingleton<GetMyStudentsCubit>(
      () => GetMyStudentsCubit(getIt()));

  getIt.registerLazySingleton<GetStudentAbsenceRepo>(
      () => GetStudentAbsenceRepo(getIt()));
  getIt.registerFactory<AbsenceCubit>(() => AbsenceCubit(getIt()));
}
