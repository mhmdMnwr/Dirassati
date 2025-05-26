import 'package:dirasati/core/helpers/date_formatter.dart';
import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:dirasati/features/notifications/data/model/notifications_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationListviewItem extends StatefulWidget {
  final NotificationModel? notification;

  const NotificationListviewItem({
    super.key,
    this.notification,
  });

  @override
  State<NotificationListviewItem> createState() =>
      _NotificationListviewItemState();
}

class _NotificationListviewItemState extends State<NotificationListviewItem> {
  bool expandedTitle = false;
  bool expandedContent = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 4.r,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildAccentStripe(context),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: _buildContent(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccentStripe(BuildContext context) {
    return Container(
      width: 4.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          bottomLeft: Radius.circular(16.r),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final dateText = widget.notification?.createdAt != null
        ? DateFormatterHelper.fomatedDate(widget.notification!.createdAt!)
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(context, dateText),
        verticalSpace(8.h),
        _buildDescription(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, String dateText) {
    return Row(
      children: [
        _buildIcon(context),
        horizontalSpace(12.w),
        _buildTitle(),
        horizontalSpace(8.w),
        _buildTimestamp(dateText),
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Stack(clipBehavior: Clip.none, children: [
          widget.notification?.getNotificationIcon ??
              Icon(
                Icons.notifications_none,
                size: 20.sp,
                color: Theme.of(context).primaryColor,
              ),
          // Notification badge the red circle that means that the notification is new
          if (widget.notification?.status == 'UNSEEN')
            Positioned(
              top: -2.h,
              right: -2.w,
              child: Container(
                height: 14.h,
                width: 14.h,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.sp,
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => expandedTitle = !expandedTitle),
        child: Text(
          widget.notification?.title ?? 'UNTITLED',
          style: TextStyles.font16BlackBold.copyWith(
            fontSize: 16.sp,
            color: const Color(0xFF222222),
          ),
          maxLines: expandedTitle ? 100 : 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildTimestamp(String dateText) {
    return Text(
      dateText,
      style: TextStyles.font12Grey.copyWith(
        fontSize: 12.sp,
        color: const Color(0xFF888888),
      ),
    );
  }

  Widget _buildDescription() {
    return InkWell(
      onTap: () => setState(() => expandedContent = !expandedContent),
      child: Text(
        widget.notification?.description ?? 'No description available.',
        style: TextStyles.font14BlackSemiBold.copyWith(
          fontSize: 14.sp,
          height: 1.4,
          color: const Color(0xFF555555),
        ),
        maxLines: expandedContent ? 100 : 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
