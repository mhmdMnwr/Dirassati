import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildAddPhotoButton extends StatelessWidget {
  final void Function() onTap;
  final bool isEnabled; // Add isEnabled flag

  const BuildAddPhotoButton({
    super.key,
    required this.onTap,
    this.isEnabled = true, // Default to true
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Only call onTap if enabled
      onTap: isEnabled ? onTap : null,
      child: Opacity(
        // Reduce opacity if disabled
        opacity: isEnabled ? 1.0 : 0.5,
        child: Container(
          margin: EdgeInsets.only(
            top: 20.h,
          ),
          height: 40.h,
          width: 200.w,
          decoration: BoxDecoration(
            // Change color slightly if disabled
            color: isEnabled ? ColorsManager.skyBlue : ColorsManager.lightGray,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Add Photo',
              style: isEnabled
                  ? TextStyles.font16Whitebold
                  // Use an existing gray style or a default one
                  : TextStyles.font16BlackBold
                      .copyWith(color: ColorsManager.gray),
            ),
          ),
        ),
      ),
    );
  }
}
