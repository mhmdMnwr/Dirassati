import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/core/widgets/notification_count_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountOption extends StatelessWidget {
  final bool isNotification;
  final String icon;
  final String title;
  final VoidCallback onTap;

  const AccountOption({
    this.isNotification = false,
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w, // Consistent padding for all languages
          vertical: 16.h,   // Better vertical spacing
        ),
        child: SizedBox(
          height: 60.h, // Reduced height for better proportions
          child: Row(
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(icon, height: 40.h, width: 40.w), // Slightly smaller icons
                  if (isNotification) NotificationCountBlocBuilder(),
                ],
              ),
              SizedBox(width: 16.w), // Consistent spacing
              Expanded(
                child: Text(
                  title, 
                  style: TextStyles.font16BlackBold,
                  textAlign: isRTL ? TextAlign.right : TextAlign.left,
                ),
              ),
              Transform.flip(
                flipX: isRTL, // Flip arrow for RTL
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: ColorsManager.mainBlue, 
                  size: 16.sp, // Slightly smaller arrow
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
