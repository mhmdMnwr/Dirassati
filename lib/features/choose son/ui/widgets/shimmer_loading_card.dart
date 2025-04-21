import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerLoadingCard extends StatelessWidget {
  const ShimmerLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: 240.w,
          height: 390.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class SonsShimmerList extends StatelessWidget {
  const SonsShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 390.h + 32.h, // card height + margin room
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: const ShimmerLoadingCard(),
          );
        },
      ),
    );
  }
}
