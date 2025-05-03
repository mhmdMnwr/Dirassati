import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/notifications/data/model/notifications_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationListviewItem extends StatelessWidget {
  final NotificationModel? notification;
  const NotificationListviewItem({super.key, this.notification});

  @override
  Widget build(BuildContext context) {
    String getDate = notification?.createdAt != null
        ? '${notification!.createdAt!.day}/${notification!.createdAt!.month}/${notification!.createdAt!.year}'
        : 'No date available';
    String getTime =
        '${notification!.createdAt!.hour.toString().padLeft(2, '0')}:${notification!.createdAt!.minute.toString().padLeft(2, '0')}';
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: _buildNotificationBody(getDate, getTime),
        ),
      ),
    );
  }

  Widget _buildNotificationBody(String date, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleRow(date, time),
        verticalSpace(5),
        _buildDesvription(),
        verticalSpace(5),
      ],
    );
  }

  Widget _buildTitleRow(String date, String time) {
    return Row(
      children: [
        Image.asset(notification?.getNotifictionIcon ?? '',
            width: 35.w, height: 35.h),
        horizontalSpace(10),
        Expanded(
          child: Text(
            notification?.title ?? 'No title',
            style: TextStyles.font22BlackBold,
          ),
        ),
        Spacer(),
        Text("$date \n$date", style: TextStyles.font16BlackBold),
      ],
    );
  }

  Widget _buildDesvription() {
    return Text(
      notification?.description ?? 'No description',
      style: TextStyles.font16BlackBold,
    );
  }
}
