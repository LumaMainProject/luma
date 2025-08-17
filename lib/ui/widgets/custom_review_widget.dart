import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/global/params/app_text_styles.dart';

class CustomReviewWidget extends StatelessWidget {
  const CustomReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppButtonStyle.customBottomNavBar,
      padding: EdgeInsets.all(14),

      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(36)),
                child: Container(color: Colors.amber, width: 35, height: 35),
              ),

              const SizedBox(width: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("NAME", style: AppTextStyles.text),

                  Row(
                    children: [
                      Icon(
                        AppIcons.raitings,
                        size: 10,
                        color: AppColors.iconColor,
                      ),
                      Icon(
                        AppIcons.raitings,
                        size: 10,
                        color: AppColors.iconColor,
                      ),
                      Icon(
                        AppIcons.raitings,
                        size: 10,
                        color: AppColors.iconColor,
                      ),
                      Icon(
                        AppIcons.raitings,
                        size: 10,
                        color: AppColors.iconColor,
                      ),
                      Icon(
                        AppIcons.raitings,
                        size: 10,
                        color: AppColors.iconColor,
                      ),
                    ],
                  ),
                ],
              ),

              const Spacer(),

              Text("15 дек", style: AppTextStyles.textButtonOutcast),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            "Отличное платье! Качество материала превосходное, очень удобное и стильное. Рекомендую всем!",
            maxLines: 3,
            style: AppTextStyles.itemPrice,
          ),
        ],
      ),
    );
  }
}
