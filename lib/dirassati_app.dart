import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/routing/app_router.dart';
import 'package:dirasati/core/language/language_cubit.dart';
import 'package:dirasati/core/di/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dirasati/generated/app_localizations.dart';

import 'core/routing/routes.dart';

class DirassatiApp extends StatelessWidget {
  final AppRouter appRouter;
  const DirassatiApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LanguageCubit>(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return ScreenUtilInit(
            designSize: const Size(412, 917),
            minTextAdapt: true,
            child: MaterialApp(
              title: AppLocalizations.of(context)?.appName ?? 'Dirassati',
              locale: locale, // Use the locale from LanguageCubit
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: ThemeData(
                primaryColor: Colors.white,
                fontFamily: 'Inter',
                scaffoldBackgroundColor: Colors.white,
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.chooseSonScreen,
              // isParentLoggedIn ? Routes.chooseSonScreen : Routes.loginScreen,
              onGenerateRoute: appRouter.generateRoute,
            ),
          );
        },
      ),
    );
  }
}
