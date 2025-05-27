import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/widgets/show_pdf_dialog.dart';
import 'package:dirasati/features/Parent%20account/ui/parent_acount_page.dart';
import 'package:dirasati/features/auth/logic/cubit/login_cubit.dart';
import 'package:dirasati/features/auth/ui/forget_password_page.dart';
import 'package:dirasati/features/auth/ui/login_page.dart';
import 'package:dirasati/features/auth/ui/otp_page.dart';
import 'package:dirasati/features/choose%20son/data/model/get_me_response.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:dirasati/features/notifications/ui/notifications_page.dart';
import 'package:dirasati/features/paiment/logic/cubit/paiment_cubit.dart';
import 'package:dirasati/features/paiment/ui/paiment_page.dart';
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
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<LoginCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<GetMyStudentsCubit>(),
              ),
            ],
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
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<GetMyStudentsCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<NotificationsCubit>(),
              ),
            ],
            child: ChooseSonPage(),
          ),
        );

      case Routes.studentProfilePage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<GetMyStudentsCubit>(),
                  child: StudentProfilePage(
                    student: arguments as Student,
                  ),
                ));

      case Routes.acountPage:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => getIt<GetMyStudentsCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => getIt<NotificationsCubit>(),
                    ),
                  ],
                  child: AccountPage(
                    parentModel: arguments as UserData,
                  ),
                ));
      case Routes.notificationPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<NotificationsCubit>(),
                  child: NotificationsPage(),
                ));
      case Routes.pdfPage:
        return MaterialPageRoute(
          builder: (_) => DirectPdfLoaderScreen(
            pdfUrl: (arguments as Map<String, dynamic>)['pdfUrl'] as String,
            pdfName: (arguments)['pdfName'] as String,
          ),
        );
      case Routes.paimentPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<PaimentCubit>(),
            child: PaimentPage(),
          ),
        );

      default:
        return null;
    }
  }
}
