import 'package:dirasati/features/choose%20son/logic/cubit/get_my_students_cubit.dart';
import 'package:dirasati/features/choose%20son/logic/cubit/get_my_students_state.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/app_bar.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/back_ground.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/shimmer_loading_card.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/sons_list.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/welcom_back_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseSonPage extends StatefulWidget {
  const ChooseSonPage({super.key});

  @override
  State<ChooseSonPage> createState() => _ChooseSonPageState();
}

class _ChooseSonPageState extends State<ChooseSonPage> {
  @override
  void initState() {
    super.initState();
    context.read<GetMyStudentsCubit>().getMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Backgroung(),
          _appBarBlocBuilder(),
          Column(
            children: [
              _parentBlocBuilder(),
              _sonsBlocBuilder(),
            ],
          )
        ],
      ),
    );
  }
}

Widget _appBarBlocBuilder() {
  return BlocBuilder<GetMyStudentsCubit, GetMyStudentsState>(
    buildWhen: (previous, current) =>
        current is GetMeloading ||
        current is GetMesuccess ||
        current is GetMeerror,
    builder: (context, state) {
      return state.whenOrNull(
            getMeloading: () {
              return MyAppBar(
                showLeadingIcon: false,
              );
            },
            getMesuccess: (parentData) {
              return MyAppBar(
                parentModel: parentData?.data,
              );
            },
            getMeerror: (error) {
              return MyAppBar(
                showLeadingIcon: false,
              );
            },
          ) ??
          SizedBox.shrink();
    },
  );
}

Widget _parentBlocBuilder() {
  return BlocBuilder<GetMyStudentsCubit, GetMyStudentsState>(
    buildWhen: (previous, current) =>
        current is GetMeloading ||
        current is GetMesuccess ||
        current is GetMeerror,
    builder: (context, state) {
      return state.whenOrNull(
            getMeloading: () {
              return WelcomBackMessage(parentName: '');
            },
            getMesuccess: (parentData) {
              String gender() {
                if (parentData.data.gender == 'Male') {
                  return 'Mr.';
                } else {
                  return 'Ms.';
                }
              }

              context
                  .read<GetMyStudentsCubit>()
                  .getMyStudents(parentId: parentData.data.id);
              return WelcomBackMessage(
                  parentName:
                      '${gender()} ${parentData.data.firstName} ${parentData.data.lastName}');
            },
            getMeerror: (error) {
              return WelcomBackMessage(parentName: 'there was a problem');
            },
          ) ??
          SizedBox.shrink();
    },
  );
}

Widget _sonsBlocBuilder() {
  return BlocBuilder<GetMyStudentsCubit, GetMyStudentsState>(
    buildWhen: (previous, current) =>
        current is Loading || current is Success || current is Error,
    builder: (context, state) {
      return state.whenOrNull(
            loading: () => setupLoading(),
            success: (studentsData) {
              return Expanded(
                  child: SonsListView(
                studentsResponse: studentsData,
              ));
            },
            error: (error) => setupError(error),
          ) ??
          SizedBox.shrink();
    },
  );
}

Widget setupError(String error) {
  return SonsShimmerList();
}

Widget setupLoading() {
  return SonsShimmerList();
}
