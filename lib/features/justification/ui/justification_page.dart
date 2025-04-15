import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/justification/data/model/send_justification_request.dart';
import 'package:dirasati/features/justification/logic/cubit/justification_cubit.dart';
import 'package:dirasati/features/justification/ui/widget/reason_of_absence_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JustificationPage extends StatefulWidget {
  const JustificationPage({super.key});

  @override
  State<JustificationPage> createState() => _JustificationPageState();
}

class _JustificationPageState extends State<JustificationPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Add if content might overflow
      child: Container(
        margin: EdgeInsets.only(
          top: 80.h,
          left: 20.w,
          right: 20.w,
          bottom: 20.h, // Add bottom margin
        ),
        constraints: BoxConstraints(
          // Add this to limit container height
          minHeight: 0, // Allow shrinking
          maxHeight: 494.h, // Set reasonable max (adjust as needed)
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(5, 8), // changes position of shadow
            ),
          ],
          color: ColorsManager.lightGray.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        width: 350.w,
        child: IntrinsicHeight(
          // Make container fit content height
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitle(),
              Spacer(),
              SizedBox(height: 20.h),
              Flexible(
                // Allows text field to expand
                child: ReasonOfAbsenceField(
                  controller: TextEditingController(),
                  hintText: 'reason of absence',
                  onChanged: (value) {},
                ),
              ),

              _buildAddPhotoButton(),
              // Pushes button to bottom
              _buildJustifyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 10,
        ),
        Image.asset(
          IconsManager.absent,
          width: 100.w,
          height: 100.h,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          '10:00 AM 20/12/2024',
          style: TextStyles.font22BlackBold,
        )
      ],
    );
  }

  Widget _buildAddPhotoButton() {
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

  Widget _buildJustifyButton() {
    return InkWell(
      onTap: () {
        context.read<JustificationCubit>().sendJustification(
              sendJustificationRequest: SendJustificationRequest(
                  parent: 'fggg', absence: 'ggg', content: 'ggggg'),
            );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 80.h,
        ),
        height: 66.h,
        width: 370.w,
        decoration: BoxDecoration(
          color: ColorsManager.skyBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Justify',
            style: TextStyles.font22Whitebold,
          ),
        ),
      ),
    );
  }
}
