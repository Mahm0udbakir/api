import 'package:dalel/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShrimmer extends StatelessWidget {
  const CustomShrimmer({
    super.key,
    this.height,
    this.shimmerContainer,
    this.separatorItem,
  });

  final double? height;
  final Widget? shimmerContainer;
  final Widget? separatorItem;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyAppColors.grey,
      highlightColor: Colors.white60,
      child: SizedBox(
        height: height,
        child: ListView.separated(
          clipBehavior: Clip.none,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return shimmerContainer ??
                Container(
                  height: 64,
                  width: 47,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
          },
          separatorBuilder: (BuildContext context, int index) {
            return separatorItem ?? const SizedBox(width: 8);
          },
          itemCount: 6,
        ),
      ),
    );
  }
}
