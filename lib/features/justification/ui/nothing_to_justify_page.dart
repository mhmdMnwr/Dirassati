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
      width: 367,
      height: 494,
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
      right: 120.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          horizontalSpace(120),
          Image.asset(
            IconsManager.nothingToJustify,
            width: 200,
            height: 200,
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
