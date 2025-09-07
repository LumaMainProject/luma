import 'package:flutter/material.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';

class SellerCardStats extends StatelessWidget {
  final IconData icon;
  final String text;
  final String subText;
  final double persent;
  const SellerCardStats({
    super.key,
    required this.icon,
    required this.persent,
    required this.subText,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsetsGeometry.all(AppSpacing.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, size: 14, color: AppColors.primary),
                AppSpacing.horizontalSm,
                Text(text, style: AppTextStyles.cardMainText, maxLines: 2),
                AppSpacing.horizontalSm,
                Icon(AppIcons.trendingUp, color: AppColors.graphUp, size: 10),
                AppSpacing.horizontalSm,
                Text(
                  "+ $persent %",
                  style: AppTextStyles.textButton.copyWith(
                    color: AppColors.graphUp,
                  ),
                  maxLines: 1,
                ),
              ],
            ),

            AppSpacing.verticalSm,

            Text(subText, style: AppTextStyles.headline, maxLines: 1),
          ],
        ),
      ),
    );
  }
}
