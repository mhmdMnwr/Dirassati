import 'package:dirasati/features/paiment/logic/cubit/paiment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/paiment_bloc_builder.dart'; // Import the new BlocBuilder widget

class PaimentPage extends StatefulWidget {
  PaimentPage({super.key});

  @override
  State<PaimentPage> createState() => _PaimentPageState();
}

class _PaimentPageState extends State<PaimentPage> {
  @override
  void initState() {
    super.initState();

    context.read<PaimentCubit>().getMyPaiment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaimentBlocBuilderWidget(),
    );
  }
}
