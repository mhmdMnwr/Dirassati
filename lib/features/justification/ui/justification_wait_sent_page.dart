import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JustificationWaitSentPage extends StatelessWidget {
  final bool waitPage;
  const JustificationWaitSentPage({
    super.key,
    this.waitPage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 360.h,
        width: 367.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(3, 4), // changes position of shadow
            ),
          ],
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              waitPage
                  ? IconsManager.justificationWait
                  : IconsManager.justificationSent,
              height: 100.h,
              width: 100.w,
            ),
            SizedBox(height: 10.h),
            Text(waitPage ? 'Sending...' : 'Justification sent',
                style: TextStyles.font22BlackBold),
          ],
        )),
      ),
    );
  }
}
