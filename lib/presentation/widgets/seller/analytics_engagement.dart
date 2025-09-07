import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/presentation/widgets/buyer/item_widget.dart';
import 'package:luma_2/presentation/widgets/seller/revenue_chart.dart';
import 'package:luma_2/data/models/revenue_point.dart';

class AnalyticsEngagement extends StatelessWidget {
  const AnalyticsEngagement({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RevenuePoint> reach = [
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 6)),
        revenue: 120,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 5)),
        revenue: 180,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 4)),
        revenue: 140,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 3)),
        revenue: 200,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 2)),
        revenue: 160,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 1)),
        revenue: 220,
      ),
      RevenuePoint(date: DateTime.now(), revenue: 190),
    ];

    final List<RevenuePoint> views = [
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 6)),
        revenue: 80,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 5)),
        revenue: 120,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 4)),
        revenue: 90,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 3)),
        revenue: 160,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 2)),
        revenue: 130,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 1)),
        revenue: 170,
      ),
      RevenuePoint(date: DateTime.now(), revenue: 150),
    ];

    final List<RevenuePoint> likes = [
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 6)),
        revenue: 20,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 5)),
        revenue: 30,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 4)),
        revenue: 25,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 3)),
        revenue: 40,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 2)),
        revenue: 35,
      ),
      RevenuePoint(
        date: DateTime.now().subtract(const Duration(days: 1)),
        revenue: 50,
      ),
      RevenuePoint(date: DateTime.now(), revenue: 45),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsetsGeometry.all(AppSpacing.paddingMd),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Вовлечение", style: AppTextStyles.headline),
                ItemWidgetTag(text: "Охват"),
                ItemWidgetTag(text: "Просмотры"),
                ItemWidgetTag(text: "Лайки"),
              ],
            ),
            RevenueChart(data: reach, dataSecond: views, dataThird: likes),
          ],
        ),
      ),
    );
  }
}
