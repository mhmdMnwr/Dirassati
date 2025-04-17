import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildAddPhotoButton extends StatelessWidget {
  const BuildAddPhotoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20.h,
      ),
      height: 40.h,
      width: 200.w,
      decoration: BoxDecoration(
        color: ColorsManager.skyBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Add Photo',
          style: TextStyles.font16Whitebold,
        ),
      ),
    );
  }
}
