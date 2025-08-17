import 'package:flutter/material.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_settings.dart';

abstract class AppButtonStyle {
  static final ButtonStyle activeRegisterPageButton = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.backgroundButtonColor),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSettings.borderAngle),
      ),
    ),
    side: WidgetStatePropertyAll(BorderSide(color: AppColors.borderColor)),
  );

  static final ButtonStyle deactiveRegisterPageButton = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.whiteColor),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSettings.borderAngle),
      ),
    ),
    side: WidgetStatePropertyAll(
      BorderSide(color: AppColors.inactiveBorderColor),
    ),
  );

  static final ButtonStyle iconButton = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.whiteColor),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSettings.borderAngle),
      ),
    ),
    side: WidgetStatePropertyAll(
      BorderSide(color: AppColors.inactiveBorderColor),
    ),
  );

  static final ButtonStyle textMajorButton = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.mainColor),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSettings.borderAngle),
      ),
    ),
    side: WidgetStatePropertyAll(BorderSide(color: AppColors.mainColor)),
  );

  static final ButtonStyle textMiddleButton = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.backgroundColor),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSettings.borderAngle),
      ),
    ),
    side: WidgetStatePropertyAll(BorderSide(color: AppColors.secondColor)),
  );

  static final ButtonStyle textMinorButton = ButtonStyle(
    padding: WidgetStatePropertyAll(EdgeInsetsGeometry.zero),
    minimumSize: WidgetStatePropertyAll(Size.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.compact,

    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  );

  static final BoxDecoration customBottomNavBar = BoxDecoration(
    color: AppColors.whiteColor,
    borderRadius: BorderRadius.all(Radius.circular(AppSettings.borderAngle)),
    border: BoxBorder.all(color: AppColors.inactiveBorderColor),
  );

  static final ButtonStyle navBarIconButton = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.whiteColor),
  );

  static final ButtonStyle navBarIconButtonActive = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.mainColor),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSettings.borderAngle),
      ),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
  );

  static final BoxDecoration circleIconActive = BoxDecoration(
    color: AppColors.whiteColor,
    borderRadius: BorderRadius.all(Radius.circular(36)),
    border: BoxBorder.all(color: AppColors.backgroundColor),

    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 1,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );

  static final BoxDecoration circleIconInActive = BoxDecoration(
    color: AppColors.whiteColor,
    borderRadius: BorderRadius.all(Radius.circular(36)),
    border: BoxBorder.all(color: AppColors.inactiveBorderColor),

    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 1,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );

  static final BoxDecoration circleIconIsFavorite = BoxDecoration(
    color: AppColors.inactiveBorderColor,
    borderRadius: BorderRadius.all(Radius.circular(36)),
    border: BoxBorder.all(color: AppColors.borderColor),

    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 1,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );

  static final BoxDecoration itemHint = BoxDecoration(
    color: AppColors.mainColor,
  );

  static final ButtonStyle itemButton = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.whiteColor),
    padding: WidgetStatePropertyAll(EdgeInsets.all(4)),
    minimumSize: WidgetStatePropertyAll(Size(22, 22)),
  );

  static final BoxDecoration buyerItemPage = BoxDecoration(
    color: AppColors.secondColor,
  );

  static final BoxDecoration sale = BoxDecoration(
    color: AppColors.saleColor,
  );
}
