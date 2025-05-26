import 'package:dio/dio.dart';
import 'package:dirasati/core/Networking/api_service.dart';
import 'package:dirasati/core/Networking/dio_factory.dart';
import 'package:dirasati/core/Networking/fetch_pdf_api_service.dart';
import 'package:dirasati/core/Networking/fetch_pdf_repo.dart';
import 'package:dirasati/features/HomeWork/data/repo/home_work_repo.dart';
import 'package:dirasati/features/HomeWork/logic/cubit/home_work_cubit.dart';
import 'package:dirasati/features/auth/data/repo/login_repo.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
import 'package:dirasati/features/change%20password/data/repo/change_password_repo.dart';
import 'package:dirasati/features/change%20password/logic/cubit/change_password_cubit.dart';
import 'package:dirasati/features/choose%20son/data/repo/get_my_studnets_repo.dart';
import 'package:dirasati/features/choose%20son/logic/cubit/get_my_students_cubit.dart';
import 'package:dirasati/features/justification/data/api/cloudinary_service.dart';
import 'package:dirasati/features/justification/data/repo/steudent_absence_repo.dart';
import 'package:dirasati/features/justification/data/repo/upload_images.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_cubit.dart';
import 'package:dirasati/features/justification/logic/cubit/upload_images_cubit.dart';
import 'package:dirasati/features/marks/data/repo/marks_repo.dart';
import 'package:dirasati/features/marks/logic/cubit/marks_cubit.dart';
import 'package:dirasati/features/notifications/data/repo/notifications_repo.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:dirasati/features/parent%20info/data/repo/update_repo.dart';
import 'package:dirasati/features/parent%20info/logic/cubit/update_parent_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  getIt.registerLazySingleton<GetMyStudentsRepo>(
      () => GetMyStudentsRepo(getIt()));
  getIt.registerFactory<GetMyStudentsCubit>(() => GetMyStudentsCubit(getIt()));

  getIt.registerLazySingleton<GetStudentAbsenceRepo>(
      () => GetStudentAbsenceRepo(getIt()));
  getIt.registerFactory<AbsenceCubit>(() => AbsenceCubit(getIt()));

  getIt.registerLazySingleton<UpdateRepo>(() => UpdateRepo(getIt()));
  getIt.registerFactory<UpdateParentCubit>(() => UpdateParentCubit(getIt()));

  getIt.registerLazySingleton<ImageUploadApiService>(
      () => ImageUploadApiService());
  getIt.registerLazySingleton<ImageUploadRepository>(
      () => ImageUploadRepository(getIt()));
  getIt.registerFactory<UploadImagesCubit>(() => UploadImagesCubit(getIt()));

  getIt
      .registerFactory<ChangePasswordCubit>(() => ChangePasswordCubit(getIt()));
  getIt.registerLazySingleton<ChangePasswordRepo>(
      () => ChangePasswordRepo(getIt()));

  getIt.registerFactory<MarksCubit>(() => MarksCubit(getIt()));
  getIt.registerLazySingleton<MarksRepository>(() => MarksRepository(getIt()));

  getIt.registerFactory<HomeWorkCubit>(() => HomeWorkCubit(getIt()));
  getIt.registerLazySingleton<HomeWorkRepository>(
      () => HomeWorkRepository(getIt()));

  getIt.registerFactory<NotificationsCubit>(() => NotificationsCubit(getIt()));
  getIt.registerLazySingleton<NotificationsRepository>(
      () => NotificationsRepository(getIt()));

  getIt.registerLazySingleton<FetchPdfRepo>(() => FetchPdfRepo(getIt()));

  getIt.registerLazySingleton<FetchPdfApiService>(() => FetchPdfApiService());
}
