import 'package:dirasati/features/notifications/data/model/notifications_model.dart';
import 'package:dirasati/features/notifications/ui/widget/notification_listview_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsListview extends StatelessWidget {
  final List<NotificationModel> allNotifications;
  final ScrollController scrollController;
  final bool isLoadingMore;

  const NotificationsListview({
    super.key,
    required this.scrollController,
    required this.isLoadingMore,
    required this.allNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(right: 16.w, left: 16.w, top: 20.h, bottom: 8.h),
        child: ListView.builder(
          controller: scrollController,
          itemCount: allNotifications.length + (isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= allNotifications.length) {
              return Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final notification = allNotifications[index];
            return NotificationListviewItem(
              notification: notification,
            );
          },
        ));
  }
}
