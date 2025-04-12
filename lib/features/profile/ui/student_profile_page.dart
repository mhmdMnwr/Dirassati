import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:dirasati/features/profile/ui/test.dart';
import 'package:dirasati/features/profile/ui/widget/sliver_appbar.dart';
import 'package:flutter/material.dart';

class StudentProfilePage extends StatelessWidget {
  final Student student;
  const StudentProfilePage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MySliverAppbar(
            student: student,
            previousContext: context,
          ),
          TabbedContentSliver(student: student),
        ],
      ),
    );
  }
}
