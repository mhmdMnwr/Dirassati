import 'dart:math' show pi;

import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/generated/app_localizations.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget notificationAppBar(BuildContext context) {
  return AppBar(
    title: Text(AppLocalizations.of(context)!.notifications),
    titleTextStyle: TextStyles.font22Whitebold,
    centerTitle: true,
    backgroundColor: ColorsManager.skyBlue,
    leading: IconButton(
      icon: Transform.rotate(
        angle: Directionality.of(context) == TextDirection.rtl ? pi : 0,
        child: Image.asset(IconsManager.backButton),
      ),
      onPressed: () {
        context.pop();
      },
    ),
  );
}
