import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/core/widgets/setup_bloc_states.dart';
import 'package:dirasati/features/marks/logic/cubit/marks_cubit.dart';
import 'package:dirasati/features/marks/logic/cubit/marks_state.dart';
import 'package:dirasati/features/marks/ui/semester_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SemestreCard extends StatelessWidget {
  final int index;
  final String year;
  final String studentId;
  const SemestreCard(
      {super.key,
      required this.index,
      required this.year,
      required this.studentId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.read<MarksCubit>().getMarks(
              studentId: studentId,
              year: year,
              trimestre: (index + 1).toString());
        },
        child: BlocListener<MarksCubit, MarksState>(
          listenWhen: (previous, current) =>
              current is MarksLoading ||
              current is MarksLoaded ||
              current is MarksError,
          listener: (context, state) {
            state.whenOrNull(
              marksLoading: () {
                SetupLoadingState.show(context);
              },
              marksLoaded: (marksResponse) {
                context.pop();
                context.pop();
                showDialog(
                  context: context,
                  builder: (context) => SemesterDetailPage(
                    marksResponse: marksResponse,
                    year: year,
                    trimestre: 'trimestre ${(index + 1)}',
                  ),
                );
              },
              error: (error) {
                context.pop();
                SetupErrorState.show(context, error);
              },
            );
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: Container(
              width: 264.w,
              height: 77.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: ColorsManager.skyBlue,
                  width: 2.sp,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Semester 0${index + 1}',
                  style: TextStyles.font24BlackBold,
                ),
              ),
            ),
          ),
        ));
  }
}
