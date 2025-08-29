import 'package:flutter/widgets.dart';

abstract class AppSpacing {
  // Вертикальные отступы
  static const verticalXs = SizedBox(height: 4);
  static const verticalSm = SizedBox(height: 8);
  static const verticalMd = SizedBox(height: 16);
  static const verticalLg = SizedBox(height: 24);
  static const verticalXl = SizedBox(height: 32);

  // Горизонтальные отступы
  static const horizontalXs = SizedBox(width: 4);
  static const horizontalSm = SizedBox(width: 8);
  static const horizontalMd = SizedBox(width: 16);
  static const horizontalLg = SizedBox(width: 24);
  static const horizontalXl = SizedBox(width: 32);

  // Padding (для контейнеров)
  static const double paddingAs = 2;
  static const double paddingXs = 4;
  static const double paddingSm = 8;
  static const double paddingMd = 16;
  static const double paddingLg = 24;
  static const double paddingXl = 32;

  // Nav bar
  static const double bottomNavBar = 100;

  // Nav bar
  static const double bottomButtonBar = 120;
}
