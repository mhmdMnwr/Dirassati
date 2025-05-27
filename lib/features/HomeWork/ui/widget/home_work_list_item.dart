import 'package:dirasati/core/helpers/extensions.dart';
import 'package:dirasati/core/helpers/spacing.dart';
import 'package:dirasati/core/routing/routes.dart';
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
    final attachments = widget.homeWork.attachments;
    if (attachments == null || attachments.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      shrinkWrap: true, // Important to make ListView work inside Column
      physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
      itemCount: attachments.length,
      itemBuilder: (context, index) {
        final url = attachments[index];
        final pdfName = _extractPdfName(url);

        return InkWell(
          onTap: () => _onAttachmentTap(context, url),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IconsManager.viewFile,
                  width: 30.w,
                  height: 30.h,
                ),
                horizontalSpace(8),
                Expanded(
                  child: Text(
                    pdfName,
                    style: TextStyles.font14BlueSemiBold.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _extractPdfName(String? url) {
    if (url == null || url.isEmpty) return 'Attachment';
    try {
      final uri = Uri.parse(url);
      String pathSegment = uri.pathSegments.last;
      // Remove .pdf extension if present
      if (pathSegment.toLowerCase().endsWith('.pdf')) {
        pathSegment = pathSegment.substring(0, pathSegment.length - 4);
      }
      // Replace underscores/hyphens with spaces for better readability
      pathSegment = pathSegment.replaceAll(RegExp(r'[_-]'), ' ');
      return pathSegment.isNotEmpty ? pathSegment : 'Attachment';
    } catch (e) {
      print('Error parsing URL for pdfName: $e');
      return 'Attachment';
    }
  }

  void _toggleExpanded() => setState(() => _isExpanded = !_isExpanded);
  void _onAttachmentTap(BuildContext context, String? url) {
    if (url == null || url.isEmpty) return;
    final pdfName = _extractPdfName(url);
    context.pushNamed(Routes.pdfPage, arguments: {
      'pdfUrl': url,
      'pdfName': pdfName,
    });
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
