import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/logic/analytics/analytics_bloc.dart';
import 'package:luma_2/presentation/widgets/seller/analytics_conversion.dart';
import 'package:luma_2/presentation/widgets/seller/analytics_engagement.dart';
import 'package:luma_2/presentation/widgets/seller/analytics_traffic_sources.dart';
import 'package:luma_2/presentation/widgets/seller/complex_analytic_card.dart';

class SellerHomepageScreenAnalitics extends StatefulWidget {
  const SellerHomepageScreenAnalitics({super.key});

  @override
  State<SellerHomepageScreenAnalitics> createState() =>
      _SellerHomepageScreenAnaliticsState();
}

class _SellerHomepageScreenAnaliticsState
    extends State<SellerHomepageScreenAnalitics> {
  int selectedDaysIndex = 0; // 0 = 7д, 1 = 30д, 2 = 90д
  int selectedTypeIndex = 0; // 0 = выручка, 1 = заказы

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      builder: (context, analyticsState) {
        if (analyticsState is! StoreAnalyticsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== Переключатель дней =====
                Row(
                  children: [
                    ToggleButtons(
                      isSelected: [
                        selectedDaysIndex == 0,
                        selectedDaysIndex == 1,
                        selectedDaysIndex == 2,
                      ],
                      onPressed: (index) {
                        setState(() {
                          selectedDaysIndex = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text("7Д"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text("30Д"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text("90Д"),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_today),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Text(
                  "Данные за период с учетом выбранных фильтров",
                  style: AppTextStyles.cardMainText,
                ),

                const SizedBox(height: 16),

                const Divider(),

                const SizedBox(height: 16),

                // ===== Метрики =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _MetricCard(title: "Охват", value: "45.2K", growth: "+12%"),
                    AppSpacing.horizontalMd,
                    _MetricCard(
                      title: "Просмотры",
                      value: "128K",
                      growth: "+18%",
                    ),
                    AppSpacing.horizontalMd,
                    _MetricCard(title: "Лайки", value: "3.2K", growth: "+5%"),
                  ],
                ),

                const SizedBox(height: 16),

                // ===== Кнопки промо =====
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text("Промо товара"),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text("Промо магазина"),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ===== График =====
                ComplexAnalyticCard(
                  revenuePoints7Days: analyticsState.revenuePoints7Days,
                  revenuePoints30Days: analyticsState.revenuePoints30Days,
                  revenuePoints90Days: analyticsState.revenuePoints90Days,
                  ordersPoints7Days: analyticsState.ordersPoints7Days,
                  ordersPoints30Days: analyticsState.ordersPoints30Days,
                  ordersPoints90Days: analyticsState.ordersPoints90Days,
                  selectedDaysIndex: selectedDaysIndex,
                ),

                const SizedBox(height: 16),

                AnalyticsEngagement(),

                const SizedBox(height: 16),
                
                AnalyticsTrafficSources(),

                const SizedBox(height: 16),
                
                AnalyticsConversion(),

                const SizedBox(height: AppSpacing.bottomNavBar),

              ],
            ),
          ),
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String growth;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.growth,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(title, style: AppTextStyles.text),
              const SizedBox(height: 8),
              Text(value, style: AppTextStyles.headline),
              Text(
                growth,
                style: const TextStyle(color: Colors.green, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
