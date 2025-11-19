import 'package:flutter/material.dart';
import 'package:inovola/core/models/purchased_item.dart';
import 'package:inovola/core/utils/date_time_helper.dart';
import 'package:inovola/core/utils/num_helper.dart';
import 'package:inovola/theme/app_styles.dart';

class RecentExpenseItemWidget extends StatelessWidget {
  const RecentExpenseItemWidget({super.key, required this.purchasedItem});

  final PurchasedItem purchasedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
        child: ListTile(
          dense: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          visualDensity: const VisualDensity(vertical: 2, horizontal: 1),
          leading: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: purchasedItem.category?.backgroundColor,
            ),
            padding: const EdgeInsets.all(12),
            child: Center(child: purchasedItem.category?.icon),
          ),
          title: Text(purchasedItem.category!.title!, style: AppStyles.labelMedium),
          subtitle: Text(purchasedItem.medium!.title!, style: AppStyles.paragraphXSmall.greyDarker),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("-\$${purchasedItem.price.asMoney}", style: AppStyles.labelSmall),
              const SizedBox(height: 2),
              Text(purchasedItem.purchaseDate.asShortDate, style: AppStyles.paragraphXSmall.greyDarker),
            ],
          ),
        ),
      ),
    );
  }
}
