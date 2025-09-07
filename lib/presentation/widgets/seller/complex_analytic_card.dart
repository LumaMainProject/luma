import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/revenue_point.dart';
import 'package:luma_2/presentation/widgets/seller/revenue_chart.dart';

class ComplexAnalyticCard extends StatefulWidget {
  final List<RevenuePoint> revenuePoints7Days;
  final List<RevenuePoint> revenuePoints30Days;
  final List<RevenuePoint> revenuePoints90Days;

  final List<RevenuePoint> ordersPoints7Days;
  final List<RevenuePoint> ordersPoints30Days;
  final List<RevenuePoint> ordersPoints90Days;

  final int selectedDaysIndex;

  const ComplexAnalyticCard({
    super.key,
    required this.revenuePoints7Days,
    required this.revenuePoints30Days,
    required this.revenuePoints90Days,
    required this.ordersPoints7Days,
    required this.ordersPoints30Days,
    required this.ordersPoints90Days,
    this.selectedDaysIndex = 0,
  });

  @override
  State<ComplexAnalyticCard> createState() => _ComplexAnalyticCardState();
}

class _ComplexAnalyticCardState extends State<ComplexAnalyticCard> {
  bool showRevenue = true;

  @override
  Widget build(BuildContext context) {
    List<RevenuePoint> currentData;
    if (showRevenue) {
      switch (widget.selectedDaysIndex) {
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
      switch (widget.selectedDaysIndex) {
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
                Text("Динамика", style: AppTextStyles.headline),
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
            RevenueChart(data: currentData),
          ],
        ),
      ),
    );
  }
}
