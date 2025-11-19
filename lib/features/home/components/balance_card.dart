import 'package:flutter/material.dart';
import 'package:inovola/core/models/currency.dart';
import 'package:inovola/core/utils/image_helper.dart';
import 'package:inovola/core/utils/num_helper.dart';
import 'package:inovola/theme/app_assets.dart';
import 'package:inovola/theme/app_colors.dart';
import 'package:inovola/theme/app_styles.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.balance,
    required this.income,
    required this.expenses,
    required this.selectedCurrency,
    required this.onCurrencyTap,
  });

  final double balance;
  final double income;
  final double expenses;
  final Currency selectedCurrency;
  final VoidCallback onCurrencyTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.blueLight,
        boxShadow: [
          BoxShadow(
            color: AppColors.blue.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            AppColors.blueLighter.withOpacity(0.96),
            AppColors.blueLight,
            AppColors.blue,
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            titleAlignment: ListTileTitleAlignment.top,
            title: Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              children: [
                Text("Total Balance", style: AppStyles.paragraphSmall.primary),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: ImageHelper.asset(
                    AppAssets.arrowUpIos,
                    color: AppColors.primary,
                    height: 14,
                    width: 14,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              "${selectedCurrency.symbol} ${balance.asMoney}",
              style: AppStyles.headingMedium.primary,
            ),
            trailing: InkWell(
              onTap: onCurrencyTap,
              child: ImageHelper.asset(
                AppAssets.more,
                color: AppColors.primary,
                height: 24,
                width: 24,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _MoneyWidget(
                  title: "Income",
                  amount: "${selectedCurrency.symbol} ${income.asMoney}",
                  iconPath: AppAssets.arrowDown,
                ),
              ),
              Expanded(
                child: _MoneyWidget(
                  title: "Expenses",
                  amount: "${selectedCurrency.symbol} ${expenses.asMoney}",
                  iconPath: AppAssets.arrowUp,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _MoneyWidget extends StatelessWidget {
  const _MoneyWidget({
    required this.title,
    required this.amount,
    required this.iconPath,
  });

  final String title;
  final String amount;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.2),
              ),
              width: 25,
              height: 25,
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: ImageHelper.asset(
                iconPath,
                color: AppColors.primary,
              ),
            ),
          ),
          Text(title, style: AppStyles.paragraphMedium.primary),
        ],
      ),
      subtitle: Text(amount, style: AppStyles.headingXSmall.primary),
    );
  }
}