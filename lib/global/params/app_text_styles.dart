import 'package:flutter/widgets.dart';
import 'package:luma/global/params/app_colors.dart';

abstract class AppTextStyles{
  static const TextStyle title = TextStyle(
    fontSize: 24,
  );
  static const TextStyle title2 = TextStyle(
    fontSize: 20,
  );
  static const TextStyle description = TextStyle(
    fontSize: 16,
  );
  static const TextStyle logo = TextStyle(
    fontSize: 18,
    color: AppColors.mainColor
  );
}