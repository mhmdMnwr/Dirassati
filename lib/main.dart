import 'package:dirasati/core/di/dependency_injection.dart';
import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/core/routing/app_router.dart';
import 'package:dirasati/dirassati_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  // To fix texts being hidden bug in flutter_screenutil in release mode.
  await ScreenUtil.ensureScreenSize();
  await checkIfLoggedInUser();
  runApp(DirassatiApp(
    appRouter: AppRouter(),
  ));
}

checkIfLoggedInUser() async {
  String? accessToken =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.accessToken);
  if (!accessToken.isNullOrEmpty()) {
    isParentLoggedIn = true;
  } else {
    isParentLoggedIn = false;
  }
}
