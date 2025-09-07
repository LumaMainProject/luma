import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/logic/analytics/analytics_bloc.dart';
import 'package:luma_2/logic/stores/stores_cubit.dart';
import 'package:luma_2/presentation/widgets/seller/analytics_card.dart';
import 'package:luma_2/presentation/widgets/seller/seller_card_stats.dart';
import 'package:luma_2/presentation/widgets/seller/seller_quick_actions.dart';
import 'package:intl/intl.dart';

class SellerHomepageScreenContent extends StatefulWidget {
  final Store store;
  const SellerHomepageScreenContent({super.key, required this.store});

  @override
  State<SellerHomepageScreenContent> createState() =>
      _SellerHomepageScreenContentState();
}

class _SellerHomepageScreenContentState
    extends State<SellerHomepageScreenContent> {
  String formatRevenue(double revenue) {
    if (revenue >= 1000000) {
      final million = revenue / 1000000;
      return "${NumberFormat("#.#", "ru").format(million)} млн";
    } else if (revenue >= 1000) {
      final thousand = revenue / 1000;
      return "${NumberFormat("#.#", "ru").format(thousand)} тыс";
    } else {
      return NumberFormat("#", "ru").format(revenue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoresCubit, StoresState>(
      builder: (context, storesState) {
        if (storesState is! StoresLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return BlocBuilder<AnalyticsBloc, AnalyticsState>(
          builder: (context, analyticsState) {
            if (analyticsState is! StoreAnalyticsLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 90 + 16 * 2,
                      child: ListView(
                        padding: const EdgeInsets.all(AppSpacing.paddingMd),
                        scrollDirection: Axis.horizontal,
                        children: [
                          SellerCardStats(
                            icon: AppIcons.sellerProducts,
                            persent: analyticsState.ordersGrowth,
                            subText: analyticsState.todayOrders.toString(),
                            text: "Заказы сегодня",
                          ),

                          AppSpacing.horizontalSm,

                          SellerCardStats(
                            icon: AppIcons.trendingUp,
                            persent: analyticsState.revenueGrowth,
                            subText: formatRevenue(analyticsState.totalRevenue),
                            text: "Выручка",
                          ),

                          AppSpacing.horizontalSm,

                          SellerCardStats(
                            icon: AppIcons.favorite,
                            persent: 0,
                            subText: widget.store.favoritesCount.toString(),
                            text: "Подписчиков",
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.paddingMd,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Быстрые действия",
                            style: AppTextStyles.headline,
                          ),
                          AppSpacing.verticalMd,
                          SellerQuickActions(store: widget.store),
                        ],
                      ),
                    ),

                    AppSpacing.verticalMd,

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.paddingMd,
                      ),
                      child: AnalyticsCard(
                        revenuePoints7Days: analyticsState.revenuePoints7Days,
                        revenuePoints30Days: analyticsState.revenuePoints30Days,
                        revenuePoints90Days: analyticsState.revenuePoints90Days,
                        ordersPoints7Days: analyticsState.ordersPoints7Days,
                        ordersPoints30Days: analyticsState.ordersPoints30Days,
                        ordersPoints90Days: analyticsState.ordersPoints90Days,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.bottomNavBar),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
