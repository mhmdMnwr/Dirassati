import 'package:dirasati/core/theming/icons.dart';
import 'package:flutter/material.dart';

class Backgroung extends StatefulWidget {
  const Backgroung({super.key});

  @override
  State<Backgroung> createState() => _BackgroungState();
}

class _BackgroungState extends State<Backgroung> {
  @override
  Widget build(BuildContext context) {
    List<Widget> backGround = [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.asset(
          IconsManager.books2,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.asset(
          IconsManager.books1,
          fit: BoxFit.cover,
        ),
      ),
    ];
    return Stack(
      children: backGround,
    );
  }
}
