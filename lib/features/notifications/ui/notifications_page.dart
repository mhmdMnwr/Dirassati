import 'package:dirasati/core/widgets/setup_bloc_states.dart';
import 'package:dirasati/features/notifications/ui/widget/notification_app_bar.dart';
import 'package:dirasati/features/notifications/ui/widget/notifications_listview.dart';
import 'package:dirasati/features/notifications/ui/widget/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_state.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<NotificationsCubit>();
    // Fetch initial data
    cubit.getNotifications(); // Cubit handles initial fetch logic

    _scrollController.addListener(() {
      // Check if scrolled near the bottom
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        // Request more data. The cubit should handle preventing duplicate fetches
        // or fetching when there's no more data.
        cubit.getNotifications();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _notificationsBlocBuilder(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final cubit = context.read<NotificationsCubit>();
        // Always get the current list from the cubit
        final allNotifications = cubit.notifications;

        return state.when(
          initial: () {
            // Show loading only on initial state before first load attempt
            return SetupLoadingState.build();
          },
          loading: () {
            // If loading the *first* page (list is empty), show full loading indicator
            if (allNotifications.isEmpty) {
              return NotificationListShimmerLoading();
            } else {
              // If loading *more* pages, show the current list + indicator at the bottom
              return NotificationsListview(
                scrollController: _scrollController,
                allNotifications: allNotifications,
                isLoadingMore: true, // Indicate loading at the end
              );
            }
          },
          success: (data, hasMore) {
            // Display the list (cubit's list should be updated)
            // Show loading indicator at the end *only if* hasMore is true
            return NotificationsListview(
              scrollController: _scrollController,
              allNotifications:
                  allNotifications, // Cubit manages the combined list
              isLoadingMore:
                  hasMore, // Show indicator if more data is available
            );
          },
          error: (error) {
            // If an error occurs, show existing items if any, otherwise show full error state
            if (allNotifications.isEmpty) {
              return SetupErrorState.build(error);
            } else {
              // Optionally show a message at the bottom or via Snackbar
              // For now, just display the list without the loading indicator
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error loading more: $error')),
                );
              });
              return NotificationsListview(
                scrollController: _scrollController,
                allNotifications: allNotifications,
                isLoadingMore: false, // Stop showing loading indicator on error
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: notificationAppBar(context),
        body: _notificationsBlocBuilder(context));
  }
}
