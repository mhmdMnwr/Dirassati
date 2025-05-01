import 'package:dirasati/core/widgets/setup_bloc_states.dart';
import 'package:dirasati/features/HomeWork/data/model/home_work_model.dart';
import 'package:dirasati/features/HomeWork/logic/cubit/home_work_cubit.dart';
import 'package:dirasati/features/HomeWork/logic/cubit/home_work_state.dart';
import 'package:dirasati/features/HomeWork/ui/widget/home_work_list.dart';
import 'package:dirasati/features/HomeWork/ui/widget/no_home_work_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWorkPage extends StatelessWidget {
  final String? studentId;
  const HomeWorkPage({super.key, this.studentId});

  @override
  Widget build(BuildContext context) {
    return _homeWorkBlocBuilder(context);
  }

  _homeWorkBlocBuilder(BuildContext context) {
    context.read<HomeWorkCubit>().getHomeWorkData(studentId: studentId ?? '');
    return BlocBuilder<HomeWorkCubit, HomeWorkState>(
      buildWhen: (previous, current) =>
          current is Loading || current is Loaded || current is Error,
      builder: (context, state) {
        return state.whenOrNull(
              loading: () => SetupLoadingState.build(),
              loaded: (homeWorkResponse) => setupLoaded(homeWorkResponse.data),
              error: (error) => SetupErrorState.build(error),
            ) ??
            SizedBox.shrink();
      },
    );
  }

  Widget setupLoaded(List<HomeWorkModel> homeWorkData) {
    if (homeWorkData.isEmpty || homeWorkData == null) {
      return const NoHomeWork();
    }
    return HomeWorkList(homeWorkData: homeWorkData);
  }
}
