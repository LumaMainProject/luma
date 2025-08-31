import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/app_notifications.dart';
import 'package:luma_2/presentation/widgets/item_widget.dart';
import 'package:shimmer/shimmer.dart';

class NotificationWidget extends StatelessWidget {
  final bool isNew;
  final AppNotification notification;

  const NotificationWidget({
    super.key,
    this.isNew = false,
    required this.notification,
  });

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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // левая цветная полоса
                    isNew
                        ? Container(width: 4, color: AppColors.primary)
                        : const SizedBox(width: 4),

                    const SizedBox(width: 10),

                    // аватар/картинка товара
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.paddingMd,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppSizes.buttonRadius,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: notification.imageUrl ?? "",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(color: Colors.white),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // текст уведомления
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.paddingMd,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              notification.title,
                              style: AppTextStyles.cardMainText,
                            ),
                            Text(
                              notification.body,
                              style: AppTextStyles.textButton,
                              maxLines: 5,
                            ),
                            if (notification.actionLabel != null)
                              ItemWidgetTag(text: notification.actionLabel!),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // кнопка справа (прочитать / время)
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
                          Text(
                            "3 МИН >", // TODO: заменить на форматированное время из createdAt
                            style: AppTextStyles.textButton,
                          ),
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
