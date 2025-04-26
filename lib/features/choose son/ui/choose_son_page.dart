import 'package:dirasati/features/choose%20son/logic/cubit/get_my_students_cubit.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/back_ground.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/choose_son_bloc_builders.dart';
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
          Background(),
          ChooseSonBlocBuilders.appBarBlocBuilder(),
          Column(
            children: [
              ChooseSonBlocBuilders.parentBlocBuilder(),
              ChooseSonBlocBuilders.sonsBlocBuilder(), // Pass context here
            ],
          )
        ],
      ),
    );
  }
}
