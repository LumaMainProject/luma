import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/revenue_point.dart';
import 'package:luma_2/presentation/widgets/seller/revenue_chart.dart';

class AnalyticsCard extends StatefulWidget {
  final List<RevenuePoint> revenuePoints7Days;
  final List<RevenuePoint> revenuePoints30Days;
  final List<RevenuePoint> revenuePoints90Days;

  final List<RevenuePoint> ordersPoints7Days;
  final List<RevenuePoint> ordersPoints30Days;
  final List<RevenuePoint> ordersPoints90Days;

  const AnalyticsCard({
    super.key,
    required this.revenuePoints7Days,
    required this.revenuePoints30Days,
    required this.revenuePoints90Days,
    required this.ordersPoints7Days,
    required this.ordersPoints30Days,
    required this.ordersPoints90Days,
  });

  @override
  State<AnalyticsCard> createState() => _AnalyticsCardState();
}

class _AnalyticsCardState extends State<AnalyticsCard> {
  bool showRevenue = true;
  final List<int> daysOptions = [7, 30, 90];
  int selectedDaysIndex = 1; // 0 = 7 дней, 1 = 30 дней, 2 = 90 дней

  @override
  Widget build(BuildContext context) {
    List<RevenuePoint> currentData;
    if (showRevenue) {
      switch (selectedDaysIndex) {
        case 0:
          currentData = widget.revenuePoints7Days;
          break;
        case 1:
          currentData = widget.revenuePoints30Days;
          break;
        case 2:
          currentData = widget.revenuePoints90Days;
          break;
        default:
          currentData = widget.revenuePoints30Days;
      }
    } else {
      switch (selectedDaysIndex) {
        case 0:
          currentData = widget.ordersPoints7Days;
          break;
        case 1:
          currentData = widget.ordersPoints30Days;
          break;
        case 2:
          currentData = widget.ordersPoints90Days;
          break;
        default:
          currentData = widget.ordersPoints30Days;
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Аналитика", style: AppTextStyles.headline),
                ToggleButtons(
                  isSelected: [showRevenue, !showRevenue],
                  onPressed: (index) {
                    setState(() {
                      showRevenue = index == 0;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("Выручка"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("Заказы"),
                    ),
                  ],
                ),
              ],
            ),
            AppSpacing.verticalMd,
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.paddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ToggleButtons(
                      isSelected: List.generate(
                        daysOptions.length,
                        (index) => index == selectedDaysIndex,
                      ),
                      onPressed: (index) {
                        setState(() {
                          selectedDaysIndex = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      children: daysOptions
                          .map(
                            (days) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text("$days"),
                            ),
                          )
                          .toList(),
                    ),
                    AppSpacing.verticalMd,
                    RevenueChart(data: currentData),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
