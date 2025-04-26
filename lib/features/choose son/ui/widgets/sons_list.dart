import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/routing/routes.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/list_view_widget.dart';
import 'package:flutter/material.dart';

class SonsListView extends StatelessWidget {
  final StudentsResponse studentsResponse;
  const SonsListView({required this.studentsResponse, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: studentsResponse.data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                context.pushNamed(
                  Routes.studentProfilePage,
                  arguments: studentsResponse.data[index],
                );
              },
              child: ListViewWidget(
                student: studentsResponse.data[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
