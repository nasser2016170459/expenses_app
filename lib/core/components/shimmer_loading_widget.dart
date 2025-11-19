import 'package:flutter/material.dart';
import 'package:inovola/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 1),
      baseColor: AppColors.greyDarker.withOpacity(0.4),
      highlightColor: AppColors.primary,
      child: AnimatedContainer(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primary,
        ),
        duration: const Duration(milliseconds: 200),
      ),
    );
  }
}
