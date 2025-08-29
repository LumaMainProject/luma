import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_sizes.dart';
import 'app_spacing.dart';

abstract class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: 'SFPro', // или твой кастомный шрифт
    // 🎨 Цветовая схема
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.background,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: AppColors.primary,
      onSurface: AppColors.primary,
      onError: Colors.white,
    ),

    scaffoldBackgroundColor: AppColors.background,

    // 🔤 Текст
    // textTheme: TextTheme(
    //   displayLarge: AppTextStyles.h1,
    //   displayMedium: AppTextStyles.h2,
    //   displaySmall: AppTextStyles.h3,
    //   bodyLarge: AppTextStyles.body,
    //   bodyMedium: AppTextStyles.body,
    //   bodySmall: AppTextStyles.caption,
    //   labelLarge: AppTextStyles.button,
    // ),

    // AppBar
    appBarTheme: AppBarTheme(
      color: AppColors.white,
      foregroundColor: AppColors.textDark, // цвет текста и иконок
      elevation: 4, // сила тени (по умолчанию 4.0)
      shadowColor: Colors.black26, // цвет тени
      centerTitle: true,
      titleTextStyle: AppTextStyles.headline,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.textDark),
    ),

    // 📦 Карточки
    cardTheme: CardThemeData(
      color: AppColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        side: BorderSide(
          color: AppColors.borderColor, // ✅ цвет границы
          width: 1.0,
        ),
      ),
      margin: const EdgeInsets.all(0),
    ),

    // 🔘 Кнопки
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: AppTextStyles.buttonDeactive,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        ),
        minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.text,
        textStyle: AppTextStyles.textButton,
        padding: EdgeInsets.zero, // 🔹 убирает внутренние отступы
        minimumSize: Size(0, 0), // 🔹 минимальные размеры
        tapTargetSize: MaterialTapTargetSize
            .shrinkWrap, // 🔹 убирает extra-padding Material
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.primary),
        textStyle: AppTextStyles.buttonDeactive,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        ),
      ),
    ),

    // ✏️ Поля ввода
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMd,
        vertical: AppSpacing.paddingSm,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputRadius),
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputRadius),
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputRadius),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      hintStyle: AppTextStyles.text,
    ),

    // 🛒 BottomNavigationBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.white,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );
}
