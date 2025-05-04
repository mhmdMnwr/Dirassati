import 'package:dirasati/core/widgets/notification_circle.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:dirasati/features/notifications/logic/cubit/notifications_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCountBlocBuilder extends StatelessWidget {
  const NotificationCountBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      buildWhen: (previous, current) =>
          current is SuccessNotificationsCount, // Listen for specific state
      builder: (context, state) {
        return state.whenOrNull(
              successNotificationsCount: (count) {
                if (count != null && count != 0) {
                  return NotificationCircle(
                    notificationCount: count,
                  );
                } else {
                  return const SizedBox
                      .shrink(); // Hide the circle if count is 0 or null
                }
              },
            ) ??
            const SizedBox.shrink();
      },
    );
  }
}
