import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:dirasati/features/profile/ui/widget/circl_avatar.dart';
import 'package:dirasati/features/profile/ui/widget/student_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySliverAppbar extends StatelessWidget {
  final Student student;
  final BuildContext previousContext;

  const MySliverAppbar(
      {super.key, required this.student, required this.previousContext});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: 740.h,
        pinned: true,
        stretch: false,
        backgroundColor: ColorsManager.skyBlue,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.none,
          title: LayoutBuilder(
            builder: (context, constraints) {
              // Calculate expansion percentage (0.0 to 1.0)
              final expansionRatio =
                  constraints.maxHeight / 200; // 200 = expandedHeight
              final isExpanded = expansionRatio > 0.7; // Adjust threshold

              return Align(
                alignment:
                    isExpanded ? Alignment.centerRight : Alignment.bottomRight,
                child: Padding(
                  padding: isExpanded
                      ? EdgeInsets.only(
                          right: 16.0.w,
                          bottom: 16.0.h,
                          top: 00.h,
                        )
                      : EdgeInsets.only(right: 20.w, top: 15.h),
                  child: titleRow(isExpanded),
                ),
              );
            },
          ),
          background: StudentDetails(
            student: student,
          ),
        ),
        leading: leadingwidget(previousContext));
  }

  Widget leadingwidget(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamedAndRemoveUntil(Routes.chooseSonScreen,
            predicate: (route) => false);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, bottom: 20),
        child: Image.asset(
          IconsManager.backButton,
          height: 50.sp,
          width: 50.sp,
        ),
      ),
    );
  }

  Widget titleRow(bool isExpanded) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!isExpanded)
          SizedBox(
            width: 220.w,
            child: Text(
              '${student.firstName} ${student.lastName}',
              style: TextStyles.font16Whitebold,
              textAlign: TextAlign.center,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        horizontalSpace(
          30,
        ),
        ElegantAvatar(
          imagePath: IconsManager.person,
          isSelected: true,
          size: isExpanded ? 90.w : 45.w,
          edgeInsents: isExpanded ? 12.sp : 6.sp,
        ),
      ],
    );
  }
}
