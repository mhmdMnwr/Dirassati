import 'package:dirasati/features/marks/ui/widget/shimmer_list.dart';
import 'package:dirasati/features/marks/ui/widget/years_list.dart';
import 'package:flutter/material.dart';

// 🧠 Model to hold year & expansion state

// 🌟 Main Marks Page
class MarksPage extends StatelessWidget {
  const MarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerList();
        } else {
          return YearsList();
        }
      },
    );
  }
}
