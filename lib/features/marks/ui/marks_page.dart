import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/widgets/setup_bloc_states.dart';
import 'package:dirasati/features/marks/data/model/years_model.dart';
import 'package:dirasati/features/marks/logic/cubit/marks_cubit.dart';
import 'package:dirasati/features/marks/logic/cubit/marks_state.dart';
import 'package:dirasati/features/marks/ui/widget/shimmer_list.dart';
import 'package:dirasati/features/marks/ui/widget/years_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🧠 Model to hold year & expansion state

// 🌟 Main Marks Page
class MarksPage extends StatelessWidget {
  final String studentId;
  const MarksPage({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return _yearsblocBuilder(context, studentId);
  }

  _yearsblocBuilder(BuildContext context, String studentId) {
    context.read<MarksCubit>().getYears(studentId: studentId);

    return BlocBuilder<MarksCubit, MarksState>(
      buildWhen: (previous, current) =>
          current is Loading || current is YearsLoaded || current is Error,
      builder: (context, state) {
        return state.whenOrNull(
              loading: () => ShimmerList(),
              yearsloaded: (yearsResponse) {
                List<YearListModel> yearsList =
                    _mapYearsToYearsListModel(yearsResponse.data);
                return YearsList(studentId: studentId, yearsList: yearsList);
              },
              error: (error) {
                SetupErrorState.show(context, error);
                return ShimmerList();
              },
            ) ??
            ShimmerList();
      },
    );
  }

  List<YearListModel> _mapYearsToYearsListModel(List<YearsModel> years) {
    List<YearListModel> yearsList = [];
    for (var year in years) {
      if (year.year != null && yearsList.dontHaveThisYear(year.year!)) {
        yearsList.add(YearListModel(
          year: year.year!,
          trimestersCount: years.where((y) => y.year == year.year).length,
        ));
      }
    }
    return yearsList;
  }
}
