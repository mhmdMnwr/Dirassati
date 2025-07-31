import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/features/choose%20son/data/model/get_me_response.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/build_acount_icon.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:dirasati/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MyAppBar extends StatelessWidget {
  final UserData? parentModel;
  bool showLeadingIcon;
  MyAppBar({super.key, this.parentModel, this.showLeadingIcon = true});

  @override
  Widget build(BuildContext context) {
    MainAxisAlignment.start;
    return Padding(
      padding: EdgeInsets.only(
        top: 30.h,
        right: 16.w,
        left: 16.w,
      ),
      child: Row(
        children: [
          Image.asset(
            IconsManager.logo,
            height: 50.h,
            width: 50.w,
          ),
          Text(
            AppLocalizations.of(context)!.appName,
            style: TextStyles.font24SkyBlueExtraBold,
          ),
          Spacer(),
          if (showLeadingIcon)
            BuildAccountIcon(
              onTap: () {
                context
                    .pushNamed(Routes.acountPage, arguments: parentModel)
                    .then((_) {
                  context.read<NotificationsCubit>().getCountNotifications();
                });
              },
              context: context,
            ),
        ],
      ),
    );
  }
}
