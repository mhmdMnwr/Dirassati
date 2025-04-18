import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/justification/data/model/send_justification_request.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildJustifyButton extends StatefulWidget {
  final GlobalKey<FormState> reasonOfabsenceKey;

  final TextEditingController content;
  final String absenceId;
  const BuildJustifyButton(
      {super.key,
      required this.content,
      required this.absenceId,
      required this.reasonOfabsenceKey});

  @override
  State<BuildJustifyButton> createState() => _BuildJustifyButtonState();
}

class _BuildJustifyButtonState extends State<BuildJustifyButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.reasonOfabsenceKey.currentState!.validate()) {
          context.read<AbsenceCubit>().sendJustification(
                sendJustificationRequest: SendJustificationRequest(
                  parent:
                      '${await SharedPrefHelper.getSecuredString(SharedPrefKeys.parentId)}',
                  absence: widget.absenceId,
                  content: widget.content.text,
                ),
              );
        }
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
