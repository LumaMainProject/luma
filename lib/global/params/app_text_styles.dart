import 'package:flutter/widgets.dart';
import 'package:luma/global/params/app_colors.dart';

abstract class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 13.8,
    color: AppColors.mainColor,
  );
  static const TextStyle title2 = TextStyle(fontSize: 20);

  static const TextStyle description = TextStyle(
    fontSize: 14,
    color: AppColors.textColor,
  );
  static const TextStyle logo = TextStyle(
    fontSize: 21,
    color: AppColors.mainColor,
  );

  static const TextStyle text = TextStyle(
    fontSize: 14,
    color: AppColors.textColor,
  );

  static const TextStyle textButtonMajor = TextStyle(
    fontSize: 14,
    color: AppColors.whiteColor,
  );

  static const TextStyle textButtonMinor = TextStyle(
    fontSize: 10.5,
    color: AppColors.textColor,
  );

  static const TextStyle textButtonOutcast = TextStyle(
    fontSize: 14,
    color: AppColors.mainColor,
  );

  static const TextStyle secondTitle = TextStyle(
    fontSize: 17.5,
    color: AppColors.textColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle itemPrice = TextStyle(
    fontSize: 12.3,
    color: AppColors.mainColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle itemBigPrice = TextStyle(
    fontSize: 16,
    color: AppColors.mainColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle itemTitle = TextStyle(
    fontSize: 10.3,
    color: AppColors.textColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle itemBigTitle = TextStyle(
    fontSize: 14,
    color: AppColors.textColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle itemSale = TextStyle(
    fontSize: 10,
    decoration: TextDecoration.lineThrough,
    color: AppColors.textColor,
  );

  static const TextStyle itemShopName = TextStyle(
    fontSize: 10,
    color: AppColors.textColor,
  );

  static const TextStyle itemHint = TextStyle(
    fontSize: 10,
    color: AppColors.whiteColor,
  );

  static const TextStyle raitings = TextStyle(
    fontSize: 12,
    color: AppColors.textColor,
  );

  static const TextStyle itemPagePrice = TextStyle(
    fontSize: 20,
    color: AppColors.textColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle itemPagePriceOff = TextStyle(
    fontSize: 14,
    color: AppColors.textColor,
    decoration: TextDecoration.lineThrough,
  );

  static const TextStyle itemPagePriceSale = TextStyle(
    fontSize: 14,
    color: AppColors.whiteColor,
  );
}
