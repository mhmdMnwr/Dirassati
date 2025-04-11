import 'package:dirasati/features/choose%20son/logic/cubit/get_my_students_cubit.dart';
import 'package:dirasati/features/choose%20son/logic/cubit/get_my_students_state.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/app_bar.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/back_ground.dart';
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
    context
        .read<GetMyStudentsCubit>()
        .getMyStudents(parentId: '67df2c150d5b672312953b16');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Backgroung(),
          MyAppBar(),
          _blocBuilder(),
        ],
      ),
    );
  }
}

Widget _blocBuilder() {
  return BlocBuilder<GetMyStudentsCubit, GetMyStudentsState>(
    buildWhen: (previous, current) =>
        current is Loading || current is Success || current is Error,
    builder: (context, state) {
      return state.whenOrNull(
            loading: () => setupLoading(),
            success: (studentsData) => setupSuccess(studentsData),
            error: (error) => setupError(error),
          ) ??
          SizedBox.shrink();
    },
  );
}

Widget setupError(String error) {
  return Container(
    color: Colors.blue,
  );
}

Widget setupSuccess(studentsData) {
  return Column(
    children: [
      WelcomBackMessage(parentName: 'Ameur Mohammed Menouer'),
      Expanded(
          child: SonsListView(
        studentsResponse: studentsData,
      )),
    ],
  );
}

Widget setupLoading() {
  return CircularProgressIndicator();
}
