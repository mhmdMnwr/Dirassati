import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/theming/icons.dart';
import 'package:dirasati/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:dirasati/features/HomeWork/data/model/home_work_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeWorkListItem extends StatefulWidget {
  final HomeWorkModel homeWork;
  const HomeWorkListItem({super.key, required this.homeWork});

  @override
  // ignore: library_private_types_in_public_api
  _HomeWorkListItemState createState() => _HomeWorkListItemState();
}

class _HomeWorkListItemState extends State<HomeWorkListItem> {
  static const _animationDuration = Duration(milliseconds: 300);
  bool _isExpanded = false;

  String get _createdDate => _formatDate(widget.homeWork.createdAt!);
  String get _dueDate => _formatDate(widget.homeWork.deadLine!);
  bool get _hasAttachment => widget.homeWork.attachments?.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: _toggleExpanded,
        child: Container(
          decoration: _cardDecoration,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                verticalSpace(8),
                _buildDueDate(),
                AnimatedCrossFade(
                  firstChild: SizedBox.shrink(),
                  secondChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(12),
                      _buildTitle(),
                      verticalSpace(8),
                      _buildDescription(),
                      if (_hasAttachment) ...[
                        verticalSpace(12),
                        _buildAttachmentIcon(),
                      ],
                    ],
                  ),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: _animationDuration,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.homeWork.subjectName ?? 'Unknown Subject',
            style: TextStyles.font22BlackBold,
          ),
        ),
        Text(
          _createdDate,
          style: TextStyles.font16BlackBold,
        ),
      ],
    );
  }

  Widget _buildDueDate() {
    return Text(
      'Du Date: $_dueDate',
      style: TextStyles.font14BlueSemiBold,
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.homeWork.title ?? 'No Title',
      style: TextStyles.font16BlackBold.copyWith(
        decoration: TextDecoration.underline,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription() {
    return Text(
      widget.homeWork.description ?? 'No Description',
      style: TextStyle(fontSize: 14.sp),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildAttachmentIcon() {
    return Center(
      child: GestureDetector(
        onTap: _onAttachmentTap,
        child: Image.asset(
          IconsManager.viewFile,
          width: 50.w,
          height: 50.h,
        ),
      ),
    );
  }

  void _toggleExpanded() => setState(() => _isExpanded = !_isExpanded);
  void _onAttachmentTap() {
    // TODO: implement attachment handling
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  BoxDecoration get _cardDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4.r,
            offset: Offset(2.w, 2.h),
          ),
        ],
      );
}
