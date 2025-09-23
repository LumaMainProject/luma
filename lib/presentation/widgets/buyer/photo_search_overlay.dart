import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/presentation/widgets/under_construction_banner.dart';

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
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.paddingSm),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload_file,
                                    size: 40,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
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
                              const UnderConstructionBanner(), // баннер сверху
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.paddingSm),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.paddingSm),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.photo_camera,
                                    size: 40,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
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
                              const UnderConstructionBanner(), // баннер и на второй карточке
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
