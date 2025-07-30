import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dirasati/generated/app_localizations.dart';

import 'core/routing/routes.dart';

class DirassatiApp extends StatelessWidget {
  final AppRouter appRouter;
  const DirassatiApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 917),
        minTextAdapt: true,
        child: MaterialApp(
          title: 'Dirassati',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            primaryColor: Colors.white,
            fontFamily: 'Inter',
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute:
              isParentLoggedIn ? Routes.chooseSonScreen : Routes.loginScreen,
          onGenerateRoute: appRouter.generateRoute,
        ));
  }
}
