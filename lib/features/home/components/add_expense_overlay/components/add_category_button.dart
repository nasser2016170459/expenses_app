import 'package:flutter/material.dart';
import 'package:inovola/core/utils/image_helper.dart';
import 'package:inovola/theme/app_assets.dart';
import 'package:inovola/theme/app_colors.dart';
import 'package:inovola/theme/app_styles.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.blue)),
            padding: const EdgeInsets.all(10),
            child: Center(
              child: ImageHelper.asset(AppAssets.add, color: AppColors.blue),
            ),
          ),
          const SizedBox(height: 4),
          Text("Add category", style: AppStyles.paragraphXSmall),
        ],
      ),
    );
  }
}
