import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

PreferredSizeWidget notificationAppBar(BuildContext context) {
  return AppBar(
    title: const Text('Notifications'),
    titleTextStyle: TextStyles.font22Whitebold,
    centerTitle: true,
    backgroundColor: ColorsManager.skyBlue,
    leading: IconButton(
      icon: Image.asset(IconsManager.backButton),
      onPressed: () {
        context.read<NotificationsCubit>().getCountNotifications();
        context.pop();
      },
    ),
  );
}
