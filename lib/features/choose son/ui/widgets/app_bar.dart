import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/features/choose%20son/data/model/get_me_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            'Dirassati',
            style: TextStyles.font24SkyBlueExtraBold,
          ),
          Spacer(),
          if (showLeadingIcon) _buildAcountIcon(context)
        ],
      ),
    );
  }

  Widget _buildAcountIcon(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(Routes.accountPage, arguments: parentModel);
        },
        child: Container(
          height: 55.h,
          width: 55.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorsManager
                  .mainBlue, // Replace with your desired blue color
              width: 3.5.sp,
            ),
            shape: BoxShape.circle,
            color: Colors.white24, // Replace with your desired color
          ),
          child: Image.asset(
            IconsManager.person, // Replace with your desired icon
            color: Colors.black,
            width: 15.h,
            height: 15.h,
          ),
        ),
      ),
    );
  }
}
