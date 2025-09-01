import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/presentation/widgets/buyer/notification_widget.dart';
import 'package:luma_2/logic/notifications/notifications_bloc.dart';
import 'package:luma_2/data/models/app_notifications.dart';

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
            onPressed: () {
              final state = context.read<NotificationsBloc>().state;
              if (state is NotificationsLoaded) {
                for (final n in state.notifications) {
                  if (!n.isRead) {
                    context.read<NotificationsBloc>().add(MarkAsRead(n));
                  }
                }
              }
            },
            child: Text("ПРОЧИТАННОЕ", style: AppTextStyles.text),
          ),
          AppSpacing.horizontalMd,
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SizedBox(
            height: 40 + AppSpacing.paddingMd * 2,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingMd,
                vertical: AppSpacing.paddingMd,
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
                      color: isActive ? AppColors.primary : AppColors.textDark,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NotificationsError) {
            return Center(child: Text("Ошибка: ${state.message}"));
          }
          if (state is NotificationsLoaded) {
            List<AppNotification> list = state.notifications;

            // Фильтр
            if (activeIndex != 0) {
              final type = filters[activeIndex].toLowerCase();
              list = list.where((n) => n.type.toLowerCase() == type).toList();
            }

            if (list.isEmpty) {
              return const Center(child: Text("Уведомлений пока нет"));
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingMd,
                vertical: AppSpacing.paddingMd,
              ),
              itemBuilder: (context, index) {
                final notif = list[index];
                return NotificationWidget(
                  isNew: !notif.isRead,
                  notification: notif,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: list.length,
            );
          }
          // По умолчанию (Initial или гостевой)
          return const Center(child: Text("Уведомлений нет"));
        },
      ),
    );
  }
}
