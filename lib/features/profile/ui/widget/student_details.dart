import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentDetails extends StatelessWidget {
  final Student student;
  const StudentDetails({super.key, required this.student});

  Widget buildStudentDetails({
    required String title,
    required String value,
    bool isTitle = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.font14WhiteMedium,
        ),
        verticalSpace(5),
        SizedBox(
          width: isTitle ? 220.w : 400.w,
          child: Text(
            value,
            style: TextStyles.font20Whitebold,
            maxLines: 4,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        verticalSpace(15)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.skyBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 30.w,
        ),
        child: Stack(children: [
          Positioned(
            bottom: -5.h,
            right: 2.w,
            child: Image.asset(
              IconsManager.appbarImg,
              width: 200.w,
              height: 200.h,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(
                120,
              ),
              buildStudentDetails(
                title: 'Family Name',
                isTitle: true,
                value: student.lastName,
              ),
              buildStudentDetails(
                title: 'First Name',
                isTitle: true,
                value: student.firstName,
              ),
              buildStudentDetails(
                title: 'Birthday',
                value:
                    '${student.birthDate.day}/${student.birthDate.month}/${student.birthDate.year}',
              ),
              buildStudentDetails(
                title: 'Gender',
                value: student.gender,
              ),
              buildStudentDetails(
                title: 'Address',
                value: student.address,
              ),
              buildStudentDetails(
                title: 'Phone',
                value: student.phone,
              ),
              buildStudentDetails(
                title: 'Email',
                value: student.email,
              ),
              buildStudentDetails(
                title: 'Level',
                value: student.level,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
