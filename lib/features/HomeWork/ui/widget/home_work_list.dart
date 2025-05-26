import 'package:dirasati/features/HomeWork/data/model/home_work_model.dart';
import 'package:dirasati/features/HomeWork/ui/widget/home_work_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeWorkList extends StatelessWidget {
  final List<HomeWorkModel> homeWorkData;
  const HomeWorkList({super.key, required this.homeWorkData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeWorkData.length,
          itemBuilder: (context, index) {
            return HomeWorkListItem(
              homeWork: homeWorkData[index],
            );
          },
        ),
      ),
    );
  }
}
