import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountHeader extends StatelessWidget {
  final String name;
  const AccountHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.skyBlue,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            verticalSpace(120.h), // push avatar/name to bottom of the appbar
            Container(
              height: 90.h,
              width: 90.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.lighterGray,
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.mainBlue.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Image.asset(
                IconsManager.person,
                width: 70.w,
                height: 70.h,
              ),
            ),
            verticalSpace(12),
            SizedBox(
              width: 200.w,
              child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.font20Whitebold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
