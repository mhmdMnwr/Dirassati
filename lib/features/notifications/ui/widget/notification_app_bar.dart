import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget notificationAppBar(BuildContext context) {
  return AppBar(
    title: const Text('Notifications'),
    titleTextStyle: TextStyles.font22Whitebold,
    centerTitle: true,
    backgroundColor: ColorsManager.skyBlue,
    leading: IconButton(
      icon: Image.asset(IconsManager.backButton),
      onPressed: () {
        context.pop();
      },
    ),
  );
}
