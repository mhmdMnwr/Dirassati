import 'package:dirasati/core/widgets/setup_bloc_states.dart';
import 'package:dirasati/features/notifications/ui/widget/notification_app_bar.dart';
import 'package:dirasati/features/notifications/ui/widget/notifications_listview.dart';
import 'package:dirasati/features/notifications/ui/widget/shimmer_loading.dart';
import 'package:dirasati/generated/app_localizations.dart';

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
    cubit.getNotifications();

    _scrollController.addListener(() {
      // Check if scrolled near the bottom
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
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
      buildWhen: (prev, curr) =>
          curr is Loading || curr is Success || curr is Error,
      builder: (context, state) {
        final notifications = context.read<NotificationsCubit>().notifications;
        Widget content;

        content = state.whenOrNull(
          loading: () {
            if (notifications.isEmpty) {
              return NotificationListShimmerLoading();
            } else {
              // Show existing list + loading indicator at the bottom
              return NotificationsListview(
                scrollController: _scrollController,
                allNotifications: notifications,
                isLoadingMore: true, // Set to true when loading more items
              );
            }
          },
          success: (data, hasMore) {
            if (notifications.isEmpty) {
              return Center(
                child: Text(AppLocalizations.of(context)!.noData),
              );
            } else {
              return NotificationsListview(
                scrollController: _scrollController,
                allNotifications: notifications,
                isLoadingMore: hasMore, // Set to true when loading more items
              );
            }
          },
          error: (message) => SetupErrorState.build(message),
        )!; // safe because buildWhen ensures state is one of those

        return content;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notificationAppBar(context),
      body: _notificationsBlocBuilder(context),
    );
  }
}
