import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';

abstract class AppTextStyles {
  static const mainTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const headline = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
    overflow: TextOverflow.ellipsis,
  );

  static const buttonDeactive = TextStyle(
    fontSize: 14,
    color: AppColors.textDark,
    overflow: TextOverflow.ellipsis,
  );

  static const buttonActive = TextStyle(fontSize: 14, color: AppColors.primary);

  static const text = TextStyle(
    fontSize: 14,
    color: AppColors.text,
    overflow: TextOverflow.ellipsis,
  );

  static const textButton = TextStyle(
    fontSize: 10.5,
    color: AppColors.text,
    overflow: TextOverflow.ellipsis,
  );

  static const cardMainText = TextStyle(
    fontSize: 12,
    color: AppColors.textDark,
    overflow: TextOverflow.ellipsis,
    decoration: TextDecoration.none, // убираем возможное подчеркивание
  );

  static const cardSecondText = TextStyle(
    fontSize: 12,
    color: AppColors.text,
    overflow: TextOverflow.ellipsis,
    decoration: TextDecoration.none,
  );

  static const cardPrice = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const cardDiscountPrice = TextStyle(
    fontSize: 10,
    color: AppColors.text,
    decoration: TextDecoration.lineThrough,
  );

  static const cardTag = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

   static const alert = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.error,
  );
}
