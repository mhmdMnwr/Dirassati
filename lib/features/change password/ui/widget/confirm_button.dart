import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmButton extends StatelessWidget {
  final void Function() onSave;

  const ConfirmButton({
    super.key,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: TextStyles.font16BlackBold),
        ),
        SizedBox(width: 8.w),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.mainBlue,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          onPressed: () => onSave(),
          child: Text('Confirm', style: TextStyles.font16Whitebold),
        ),
      ],
    );
  }
}
