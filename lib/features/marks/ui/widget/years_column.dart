import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/widgets/setup_bloc_states.dart';
import 'package:dirasati/features/marks/logic/cubit/marks_cubit.dart';
import 'package:dirasati/features/marks/logic/cubit/marks_state.dart';
import 'package:dirasati/features/marks/ui/semester_details_page.dart';
import 'package:dirasati/features/marks/ui/widget/semestre_list.dart';
import 'package:dirasati/features/marks/ui/widget/year_card.dart';
import 'package:dirasati/features/marks/ui/widget/years_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class YearsColumn extends StatelessWidget {
//   final YearModel model;
//   final VoidCallback onTap;

//   const YearsColumn({super.key, required this.model, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 15.h),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Column(
//           children: [
//             YearCard(yearText: model.year),
//             if (model.isExpanded) SemestresList(),
//           ],
//         ),
//       ),
//     );
//   }
// }
class YearsColumn extends StatefulWidget {
  final YearListModel model;
  final VoidCallback onTap;
  final String studentId;

  const YearsColumn(
      {super.key,
      required this.model,
      required this.onTap,
      required this.studentId});

  @override
  State<YearsColumn> createState() => _YearsColumnState();
}

class _YearsColumnState extends State<YearsColumn>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              YearCard(yearText: widget.model.year),
              if (widget.model.isExpanded)
                _semesterListBlocListener(
                  context,
                  widget.model.year,
                  widget.model.trimestersCount.toString(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _semesterListBlocListener(BuildContext context, year, trim) {
    return BlocListener<MarksCubit, MarksState>(
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
            showDialog(
              context: context,
              builder: (context) => SemesterDetailPage(
                marksResponse: marksResponse,
                year: year,
                trimestre: trim,
              ),
            );
          },
          error: (error) {
            context.pop();
            SetupErrorState.show(context, error);
          },
        );
      },
      child: SemesterList(
        year: widget.model.year,
        syudentId: widget.studentId,
        trimestersCount: widget.model.trimestersCount,
      ),
    );
  }
}
