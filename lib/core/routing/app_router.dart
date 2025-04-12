import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
import 'package:dirasati/features/auth/ui/forget_password_page.dart';
import 'package:dirasati/features/auth/ui/login_page.dart';
import 'package:dirasati/features/auth/ui/otp_page.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:dirasati/features/profile/ui/student_profile_page.dart';
import 'package:dirasati/features/auth/ui/reset_password_page.dart';
import 'package:dirasati/features/choose%20son/logic/cubit/get_my_students_cubit.dart';
import 'package:dirasati/features/choose%20son/ui/choose_son_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../di/dependency_injection.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: LoginScreen(),
          ),
        );
      case Routes.forgetScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: ForgetPasswordPage(),
          ),
        );
      case Routes.otpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: OtpPage(),
          ),
        );
      case Routes.rsetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: ResetPasswordPage(),
          ),
        );
      case Routes.chooseSonScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<GetMyStudentsCubit>(),
            child: ChooseSonPage(),
          ),
        );

      case Routes.studentProfilePage:
        final student = Student(
          id: '1',
          firstName: 'Ameur Mohammed Menouer',
          lastName: 'Doe',
          email: 'johndoe@example.com',
          role: 'Student',
          classId: '10A',
          code: 'ST12345',
          level: '10th Grade',
          birthDate: DateTime(2007, 5, 15),
          inscriptionDate: DateTime(2022, 9, 1),
          gender: 'Male',
          phone: '123-456-7890',
          address: '123 Main Street',
          isAbsent: false,
        );
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<GetMyStudentsCubit>(),
                  child: StudentProfilePage(
                    student: student,
                  ),
                ));

      default:
        return null;
    }
  }
}
