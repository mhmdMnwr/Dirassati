import 'package:dirasati/core/di/dependency_injection.dart';
import 'package:dirasati/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  // To fix texts being hidden bug in flutter_screenutil in release mode.
  await ScreenUtil.ensureScreenSize();

  runApp(Dirassati(appRouter: AppRouter()));
}

class Dirassati extends StatelessWidget {
  final AppRouter appRouter;
  const Dirassati({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 917),
        minTextAdapt: true,
        child: MaterialApp(
          title: 'Doc App',
          theme: ThemeData(
            primaryColor: Colors.white,
            fontFamily: 'Inter',
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.studentProfilePage,
          onGenerateRoute: appRouter.generateRoute,
        ));
  }
}
