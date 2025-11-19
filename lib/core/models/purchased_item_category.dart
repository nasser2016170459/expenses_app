import 'package:flutter/material.dart';
import 'package:inovola/core/utils/image_helper.dart';
import 'package:inovola/core/utils/string_helper.dart';
import 'package:inovola/theme/app_assets.dart';
import 'package:inovola/theme/app_colors.dart';

enum PurchasedItemCategory {
  GROCERY,
  ENTERTAINMENT,
  GAS,
  SHOPPING,
  NEWSPAPER,
  TRANSPORTATION,
  RENT;

  String? get title => StringHelper.capitalize(name.replaceAll("_", " ").toLowerCase());

  Widget get icon {
    switch (this) {
      case PurchasedItemCategory.GROCERY:
        return ImageHelper.asset(AppAssets.shoppingCart, color: AppColors.blueLight, width: 24, height: 24);
      case PurchasedItemCategory.ENTERTAINMENT:
        return ImageHelper.asset(AppAssets.coffee, color: AppColors.primary, width: 24, height: 24);
      case PurchasedItemCategory.TRANSPORTATION:
        return ImageHelper.asset(AppAssets.car, color: AppColors.blue, width: 24, height: 24);
      case PurchasedItemCategory.GAS:
        return ImageHelper.asset(AppAssets.gas, color: AppColors.error, width: 24, height: 24);
      case PurchasedItemCategory.SHOPPING:
        return ImageHelper.asset(AppAssets.bag, color: AppColors.yellow, width: 24, height: 24);
      case PurchasedItemCategory.RENT:
        return ImageHelper.asset(AppAssets.moneyBag, color: AppColors.yellow, width: 24, height: 24);
      case PurchasedItemCategory.NEWSPAPER:
        return ImageHelper.asset(AppAssets.newspaper, color: AppColors.yellowDark, width: 24, height: 24);
    }
  }

  Color get backgroundColor {
    switch (this) {
      case PurchasedItemCategory.GROCERY:
        return AppColors.greyLight;
      case PurchasedItemCategory.ENTERTAINMENT:
        return AppColors.blue;
      case PurchasedItemCategory.TRANSPORTATION:
        return AppColors.purple;
      case PurchasedItemCategory.GAS:
        return AppColors.error.withOpacity(0.2);
      case PurchasedItemCategory.SHOPPING:
        return AppColors.yellowLight.withOpacity(0.3);
      case PurchasedItemCategory.RENT:
        return AppColors.yellowLight.withOpacity(0.2);
      case PurchasedItemCategory.NEWSPAPER:
        return AppColors.yellowDark.withOpacity(0.4);
    }
  }
}
