import 'package:flutter/material.dart';
import 'package:inovola/core/components/app_navigation_scaffold/components/bottom_nav_bar_item_widget.dart';
import 'package:inovola/core/utils/image_helper.dart';
import 'package:inovola/features/home/components/add_expense_overlay/add_expense_overlay.dart';
import 'package:inovola/theme/app_assets.dart';
import 'package:inovola/theme/app_colors.dart';

class AppNavigationScaffold extends StatelessWidget {
  const AppNavigationScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.greyLight,
              AppColors.purple.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.5, 1.0],
          )),
          child: child,
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          Card(
            elevation: 8,
            shadowColor: AppColors.greyDarker,
            color: AppColors.primary,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: SizedBox(
              height: 65,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BottomNavBarItemWidget(
                          isSelected: true,
                          iconPath: AppAssets.home,
                          onTap: () {},
                        ),
                        BottomNavBarItemWidget(
                          isSelected: false,
                          iconPath: AppAssets.bars,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BottomNavBarItemWidget(
                          isSelected: false,
                          iconPath: AppAssets.wallet,
                          onTap: () {},
                        ),
                        BottomNavBarItemWidget(
                          isSelected: false,
                          iconPath: AppAssets.person,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            start: (MediaQuery.of(context).size.width - 50) / 2,
            bottom: 6,
            child: InkWell(
              onTap: () => AddExpenseOverlay.show(context: context),
              splashColor: AppColors.greyDarker,
              highlightColor: AppColors.greyDarker,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blue,
                ),
                child: ImageHelper.asset(
                  AppAssets.add,
                  width: 28,
                  height: 28,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
