import 'package:flutter/material.dart';
import 'package:inovola/core/utils/image_helper.dart';
import 'package:inovola/theme/app_colors.dart';

class BottomNavBarItemWidget extends StatelessWidget {
  const BottomNavBarItemWidget({
    super.key,
    required this.isSelected,
    required this.iconPath,
    required this.onTap,
  });

  final bool isSelected;
  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: AppColors.greyLight,
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: ImageHelper.asset(
        iconPath,
        width: 30,
        height: 30,
        color: isSelected ? AppColors.blue : Colors.grey,
      ),
    );
  }
}
