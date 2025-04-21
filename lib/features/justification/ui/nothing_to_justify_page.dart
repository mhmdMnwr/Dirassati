import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NothingToJustifyPage extends StatelessWidget {
  const NothingToJustifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 367.w,
      height: 494.h,
      child: Stack(children: [
        _buildBackground(),
        _buildIcon(),
      ]),
    );
  }

  Widget _buildBackground() {
    return Positioned(
      bottom: 10.h,
      child: Image.asset(
        IconsManager.justificationBackGround,
        width: 400.w,
        height: 350.h,
      ),
    );
  }

  Widget _buildIcon() {
    return Positioned(
      right: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          verticalSpace(120),
          Image.asset(
            IconsManager.nothingToJustify,
            width: 200.w,
            height: 200.h,
          ),
          Text(
            'Nothing to Justify',
            style: TextStyles.font22BlackBold,
          ),
        ],
      ),
    );
  }
}
