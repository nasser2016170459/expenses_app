import 'package:flutter/material.dart';
import 'package:inovola/core/models/purchased_item_category.dart';
import 'package:inovola/theme/app_styles.dart';

class ExpenseCategoryItemWidget extends StatelessWidget {
  const ExpenseCategoryItemWidget({super.key, required this.category});

  final PurchasedItemCategory category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: category.backgroundColor,
          ),
          padding: const EdgeInsets.all(10),
          child: Center(child: category.icon),
        ),
        const SizedBox(height: 4),
        Text(category.title!, style: AppStyles.paragraphXSmall),
      ],
    );
  }
}
