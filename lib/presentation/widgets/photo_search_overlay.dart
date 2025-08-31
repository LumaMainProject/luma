import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';

class PhotoSearchOverlay extends StatelessWidget {
  final VoidCallback onClose;

  const PhotoSearchOverlay({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Полупрозрачный размытый фон
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(color: Colors.black.withAlpha(120)),
        ),
        // Центрированный контейнер
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: const EdgeInsets.all(AppSpacing.paddingMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Иконка камеры
                Icon(Icons.camera_alt, size: 48, color: AppColors.primary),
                const SizedBox(height: AppSpacing.paddingSm),
                Text(
                  "Поиск по фото — скоро",
                  style: AppTextStyles.cardMainText,
                  maxLines: 5,
                ),
                const SizedBox(height: 6),
                Text(
                  "Мы работаем над функцией распознавания вещей по фото.",
                  style: AppTextStyles.cardSecondText,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                ),
                const SizedBox(height: AppSpacing.paddingMd),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.paddingSm),
                          child: Column(
                            children: [
                              Icon(
                                Icons.upload_file,
                                size: 40,
                                color: AppColors.primary,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Загрузить фото",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "в разработке",
                                style: AppTextStyles.textButton,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.paddingSm),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.paddingSm),
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_camera,
                                size: 40,
                                color: AppColors.primary,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Открыть камеру",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "в разработке",
                                style: AppTextStyles.textButton,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.paddingMd),
                ElevatedButton(
                  onPressed: onClose,
                  child: const Text("Понятно"),
                ),
                const SizedBox(height: 6),
                TextButton(
                  onPressed: () {},
                  child: const Text("Посмотреть демо (скоро)"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
