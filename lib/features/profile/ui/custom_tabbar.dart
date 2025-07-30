import 'package:dirasati/core/di/dependency_injection.dart';
import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/colors.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/HomeWork/logic/cubit/home_work_cubit.dart';
import 'package:dirasati/features/HomeWork/ui/home_work_page.dart';
import 'package:dirasati/features/announcement/ui/announcement_page.dart';
import 'package:dirasati/features/choose%20son/data/model/students_response.dart';
import 'package:dirasati/features/justification/logic/cubit/absence_cubit.dart';
import 'package:dirasati/features/justification/logic/cubit/upload_images_cubit.dart';
import 'package:dirasati/features/justification/ui/absence_page.dart';
import 'package:dirasati/features/marks/data/repo/marks_repo.dart';
import 'package:dirasati/features/marks/logic/cubit/marks_cubit.dart';
import 'package:dirasati/features/marks/ui/marks_page.dart';
import 'package:dirasati/features/schedule/ui/schedule_page.dart';
import 'package:dirasati/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabbedContentSliver extends StatefulWidget {
  final Student student;

  const TabbedContentSliver({super.key, required this.student});

  @override
  State<TabbedContentSliver> createState() => _TabbedContentSliverState();
}

class _TabbedContentSliverState extends State<TabbedContentSliver> {
  List<String> getTabTitles(BuildContext context) {
    return [
      AppLocalizations.of(context)!.announcement,
      AppLocalizations.of(context)!.schedule,
      AppLocalizations.of(context)!.marks,
      AppLocalizations.of(context)!.home_work,
      AppLocalizations.of(context)!.absence,
    ];
  }

  final List<String> icons = [
    IconsManager.announcement,
    IconsManager.schedule,
    IconsManager.marks,
    IconsManager.homeWork,
    IconsManager.absence,
  ];

  int current = 0;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        _buildTabBar(),
        _buildContentArea(),
      ]),
    );
  }

  Widget _buildTabBar() {
    final tabTitles = getTabTitles(context);
    return SizedBox(
      height: 80.h,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: tabTitles.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return _buildTabItem(index);
        },
      ),
    );
  }

  Widget _buildTabItem(int index) {
    final tabTitles = getTabTitles(context);
    return GestureDetector(
      onTap: () => _handleTabChange(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.fromLTRB(
          12.w,
          12.h,
          index == 4 ? 12.w : 0.w,
          12.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorsManager.skyBlue, width: 3.2),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  icons[index],
                  height: 35.h,
                  width: 35.w,
                ),
                if (current == index) verticalSpace(10),
                if (current == index)
                  Text(
                    tabTitles[index],
                    style: TextStyles.font16BlackBold,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleTabChange(int index) {
    setState(() => current = index);
    pageController.animateToPage(
      current,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  Widget _buildContentArea() {
    final tabTitles = getTabTitles(context);
    return SizedBox(
      height: 750.h,
      child: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tabTitles.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return AnnouncementPage();
          } else if (index == 1) {
            return SchedulePage(
              student: widget.student,
            );
          } else if (index == 2) {
            return BlocProvider(
              create: (context) => MarksCubit(getIt<MarksRepository>()),
              child: MarksPage(
                studentId: widget.student.id,
              ),
            );
          } else if (index == 3) {
            return BlocProvider(
              create: (context) => getIt<HomeWorkCubit>(),
              child: HomeWorkPage(
                studentId: widget.student.id,
              ),
            );
          } else {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<AbsenceCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<UploadImagesCubit>(),
                ),
              ],
              child: AbsencePage(
                student: widget.student,
              ),
            );
          }
          //)
        },
      ),
    );
  }
}
