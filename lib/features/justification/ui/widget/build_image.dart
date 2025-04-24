// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePreviewGrid extends StatefulWidget {
  final List<File> imageFiles;
  final Function(int) onRemoveImage;

  ImagePreviewGrid({
    Key? key,
    required this.imageFiles,
    required this.onRemoveImage,
  }) : super(key: key);

  @override
  State<ImagePreviewGrid> createState() => _ImagePreviewGridState();
}

class _ImagePreviewGridState extends State<ImagePreviewGrid> {
  @override
  Widget build(BuildContext context) {
    if (widget.imageFiles.isEmpty) {
      return const SizedBox.shrink(); // Return an empty widget if no images
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: SizedBox(
        height: 100.h, // Give the GridView a fixed height
        child: GridView.builder(
          scrollDirection: Axis.horizontal, // Make it scroll horizontally
          itemCount: widget.imageFiles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // Display items in a single row
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
            childAspectRatio: 1, // Make items square
          ),
          itemBuilder: (context, index) {
            return _buildImagePreviewItem(index);
          },
        ),
      ),
    );
  }

  // Builds a single image preview item with remove button
  Widget _buildImagePreviewItem(int index) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.file(
            widget.imageFiles[index],
            fit: BoxFit.cover,
            width: 100.w, // Fixed width for horizontal items
            height: 100.h, // Fixed height for horizontal items
          ),
        ),
        // Remove button
        InkWell(
          onTap: () => widget.onRemoveImage(index),
          child: Container(
            margin: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
        ),
      ],
    );
  }
}
