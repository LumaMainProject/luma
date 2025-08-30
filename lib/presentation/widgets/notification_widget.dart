import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/presentation/widgets/item_widget.dart';

class NotificationWidget extends StatelessWidget {
  final bool isNew;
  const NotificationWidget({super.key, this.isNew = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
            border: Border.all(color: AppColors.borderColor),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // важно!
                  children: [
                    isNew
                        ? Container(width: 4, color: AppColors.primary)
                        : const SizedBox(width: 4),

                    const SizedBox(width: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.paddingMd,
                      ),
                      child: Align(
                        alignment:
                            Alignment.topCenter, // или .centerLeft, если нужно
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(36),
                            child: Container(color: Colors.amber),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.paddingMd,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Новый заказ",
                            style: AppTextStyles.cardMainText,
                          ),
                          Text(
                            "Urban подтвердил ваш заказ • 3 мин назад",
                            style: AppTextStyles.textButton,
                            maxLines: 5,
                          ),
                          ItemWidgetTag(text: "Посмотреть"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(AppSpacing.paddingMd),
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isNew
                              ? const Icon(
                                  Icons.circle,
                                  color: AppColors.primary,
                                  size: 8,
                                )
                              : const SizedBox(width: 8),
                          const SizedBox(width: 4),
                          Text("3 МИН >", style: AppTextStyles.textButton),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
