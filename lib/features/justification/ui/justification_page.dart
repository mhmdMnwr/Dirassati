import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/features/justification/data/model/absence_response.dart';
import 'package:dirasati/features/justification/ui/widget/build_add_photo_button.dart';
import 'package:dirasati/features/justification/ui/widget/build_justification_title.dart';
import 'package:dirasati/features/justification/ui/widget/build_justify_button.dart';
import 'package:dirasati/features/justification/ui/widget/reason_of_absence_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JustificationPage extends StatefulWidget {
  final AbsenceData absenceData;
  const JustificationPage({
    super.key,
    required this.absenceData,
  });
  @override
  State<JustificationPage> createState() => _JustificationPageState();
}

class _JustificationPageState extends State<JustificationPage> {
  late final TextEditingController _contentController;
  late final GlobalKey<FormState> reasonOfAbsenceKey = GlobalKey<FormState>();
  @override
  void initState() {
    _contentController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          top: 80.h,
          left: 20.w,
          right: 20.w,
          bottom: 20.h,
        ),
        constraints: BoxConstraints(
          maxHeight: 694.h,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(5, 8),
            ),
          ],
          // ignore: deprecated_member_use
          color: ColorsManager.lightGray.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        width: 350.w,
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BuildJustificationTitle(
                subjectName: widget.absenceData.subjectName,
                absentSinceDate: widget.absenceData.absentSince,
              ),
              Spacer(),
              verticalSpace(20),
              ReasonOfAbsenceField(
                raeasonOfAbsenceKey: reasonOfAbsenceKey,
                controller: _contentController,
                hintText: 'reason of absence',
                onChanged: (value) {},
              ),
              BuildAddPhotoButton(),
              BuildJustifyButton(
                reasonOfabsenceKey: reasonOfAbsenceKey,
                absenceId: widget.absenceData.id,
                content: _contentController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
