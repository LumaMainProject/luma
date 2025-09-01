import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';

class ProductSpecs extends StatelessWidget {
  final Map<String, String> specs;

  const ProductSpecs({super.key, required this.specs});

  @override
  Widget build(BuildContext context) {
    final entries = specs.entries.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Характеристики", style: AppTextStyles.headline),
          AppSpacing.verticalSm,
          Container(
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.paddingMd),
            padding: const EdgeInsets.all(AppSpacing.paddingMd),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              color: AppColors.white,
              border: Border.all(color: AppColors.borderColor),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              separatorBuilder: (_, __) => const Divider(),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.paddingXs,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ключ слева
                      Text(
                        entry.key,
                        style: AppTextStyles.text.copyWith(
                          color: AppColors.textDark,
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Значение справа, переносится при необходимости
                      Expanded(
                        child: Text(
                          entry.value,
                          style: AppTextStyles.text,
                          textAlign: TextAlign.right,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
