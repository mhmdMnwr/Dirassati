import 'package:dirasati/features/choose%20son/logic/cubit/get_my_students_cubit.dart';
import 'package:dirasati/features/choose%20son/logic/cubit/get_my_students_state.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/app_bar.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/shimmer_loading_card.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/sons_list.dart';
import 'package:dirasati/features/choose%20son/ui/widgets/welcom_back_message.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseSonBlocBuilders {
  static Widget appBarBlocBuilder() {
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

  static Widget parentBlocBuilder() {
    return BlocBuilder<GetMyStudentsCubit, GetMyStudentsState>(
      buildWhen: (previous, current) =>
          current is GetMeloading ||
          current is GetMesuccess ||
          current is GetMeerror,
      builder: (context, state) {
        return state.whenOrNull(
              getMeloading: () {
                // Consider showing a shimmer/placeholder for parent name too
                return WelcomBackMessage(parentName: 'Loading...');
              },
              getMesuccess: (parentData) {
                context.read<NotificationsCubit>().getCountNotifications();
                String getParenTitle(String? gender) {
                  if (gender == 'Male') {
                    return 'Mr.';
                  } else if (gender == 'Female') {
                    return 'Ms.';
                  }
                  return '';
                }

                return WelcomBackMessage(
                    parentName:
                        '${getParenTitle(parentData.data.gender)} ${parentData.data.firstName} ${parentData.data.lastName}');
              },
              getMeerror: (error) {
                return WelcomBackMessage(parentName: 'Could not load user');
              },
            ) ??
            WelcomBackMessage(parentName: '');
      },
    );
  }

  static Widget sonsBlocBuilder() {
    return BlocBuilder<GetMyStudentsCubit, GetMyStudentsState>(
      // Consolidate buildWhen conditions if possible, ensure all relevant states trigger rebuilds
      buildWhen: (previous, current) =>
          current is Loading ||
          current is Success ||
          current is Error ||
          current is GetMeloading ||
          current is GetMesuccess ||
          current is GetMeerror,
      builder: (context, state) {
        return state.whenOrNull(
              loading: () => _setupLoading(),
              success: (studentsData) {
                if (studentsData.data.isEmpty) {
                  return Center(child: Text('No students found.'));
                }
                return Expanded(
                    child: SonsListView(
                  studentsResponse: studentsData,
                ));
              },
              error: (error) => _setupError(context, error),
              getMeloading: () => _setupLoading(),
              getMesuccess: (parentData) {
                return _setupLoading();
              },
              getMeerror: (error) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'An error occurred loading initial data: $error',
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<GetMyStudentsCubit>().getMe();
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              },
            ) ??
            SizedBox.shrink();
      },
    );
  }

  static Widget _setupError(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Failed to load students: $error', // Display the specific error
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<GetMyStudentsCubit>().getMe();
              },
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

// setupLoading remains the same
  static Widget _setupLoading() {
    return SonsShimmerList();
  }
}
