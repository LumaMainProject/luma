import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/presentation/widgets/notification_widget.dart';

class BuyerNotifications extends StatefulWidget {
  const BuyerNotifications({super.key});

  @override
  State<BuyerNotifications> createState() => _BuyerNotificationsState();
}

class _BuyerNotificationsState extends State<BuyerNotifications> {
  int activeIndex = 0;

  final List<String> filters = [
    "Все",
    "Заказы",
    "Доставка",
    "В наличии",
    "Промо",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Уведомления"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("ПРОЧИТАННОЕ", style: AppTextStyles.text),
          ),

          AppSpacing.horizontalMd,
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.paddingMd,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final isActive = activeIndex == index;
                    return OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: isActive
                            ? AppColors.primary.withAlpha(30)
                            : AppColors.white,
                        side: BorderSide(
                          color: isActive
                              ? AppColors.primary
                              : AppColors.borderColor,
                        ),
                      ),
                      onPressed: () {
                        setState(() => activeIndex = index);
                      },
                      child: Text(
                        filters[index],
                        style: AppTextStyles.text.copyWith(
                          color: isActive
                              ? AppColors.primary
                              : AppColors.textDark,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMd,
                ),
                child: Text(
                  "СЕГОДНЯ, 14 АВГУСТА",
                  style: AppTextStyles.cardSecondText,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingMd),
        separatorBuilder: (context, index) {
          if (index == 0) {
            return Text("Сегодня", style: AppTextStyles.headline);
          }
          if (index == 5) {
            return Text("Вчера", style: AppTextStyles.headline);
          }
          if (index == 8) {
            return Text("На этой неделе", style: AppTextStyles.headline);
          }
          return NotificationWidget(isNew: index <= 2);
        },
        itemBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: 20,
      ),
    );
  }
}
