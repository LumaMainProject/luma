import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/order_status.dart';
import 'package:luma_2/logic/user/user_bloc.dart';
import 'package:luma_2/presentation/widgets/in_track_order_widget.dart';

class BuyerAccountOrders extends StatefulWidget {
  const BuyerAccountOrders({super.key});

  @override
  State<BuyerAccountOrders> createState() => _BuyerAccountOrdersState();
}

class _BuyerAccountOrdersState extends State<BuyerAccountOrders> {
  int activeIndex = 0;

  final List<String> filters = ["Все", "В обработке", "Доставка", "Доставлено"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Заказы"),
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
                  onPressed: () => setState(() => activeIndex = index),
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
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            List orders = state.user.inTrackOrders;

            // Фильтр через OrderStatus
            if (activeIndex != 0) {
              final selectedFilter = filters[activeIndex];
              orders = orders.where((o) {
                final status = OrderStatusExtension.fromString(o.status);
                return status.label == selectedFilter;
              }).toList();
            }

            if (orders.isEmpty) {
              return const Center(child: Text("Нет текущих заказов"));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final order = orders[index];
                return InTrackOrderWidget(order: order);
              },
            );
          } else if (state is UserError) {
            return Center(child: Text("Ошибка: ${state.message}"));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
