import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/justification/data/model/absence_response.dart';
import 'package:dirasati/features/justification/logic/cubit/upload_images_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JustificationWaitSentPage extends StatelessWidget {
  final AbsenceData? absenceData;
  final bool waitPage;
  const JustificationWaitSentPage({
    this.absenceData,
    super.key,
    this.waitPage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 360.h,
        width: 367.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(3, 4), // changes position of shadow
            ),
          ],
        ),
        child: Center(
            child: waitPage
                ? buildWaitingPage()
                : buildJustificationSentPage(
                    context, absenceData?.justification?.attachments ?? [])),
      ),
    );
  }

  Widget buildWaitingPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          IconsManager.justificationWait,
          height: 100.h,
          width: 100.w,
        ),
        verticalSpace(10),
        Text('Sending...', style: TextStyles.font22BlackBold),
      ],
    );
  }

  Widget buildJustificationSentPage(
      BuildContext context, List<String> imagesNames) {
    return Column(
      children: [
        verticalSpace(100),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              IconsManager.justificationSent,
              height: 100.h,
              width: 100.w,
            ),
            horizontalSpace(10),
            Text('Justification \n Sent', style: TextStyles.font22BlackBold),
          ],
        ),
        Spacer(),
        _buildEditButton(context, imagesNames)
      ],
    );
  }

  Widget _buildEditButton(BuildContext context, List<String> imagesNames) {
    return InkWell(
      onTap: () {
        if (imagesNames.isNotEmpty) {
          context.read<UploadImagesCubit>().fetchImageFile(imagesNames);
        } else {
          context.read<UploadImagesCubit>().emitUpdateState();
        }
      },
      child: Container(
        height: 66.h,
        width: 367.w,
        decoration: BoxDecoration(
          color: ColorsManager.skyBlue,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(1, 0), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Edit',
            style: TextStyles.font24WhiteSemiBold,
          ),
        ),
      ),
    );
  }
}
