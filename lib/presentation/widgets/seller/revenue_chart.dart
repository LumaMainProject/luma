import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/data/models/revenue_point.dart';

class RevenueChart extends StatelessWidget {
  final List<RevenuePoint> data;

  const RevenueChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false), // без сетки
            borderData: FlBorderData(show: false), // без рамки

            titlesData: FlTitlesData(
              topTitles: AxisTitles(),
              leftTitles: AxisTitles(),
            ),

            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  data.length,
                  (index) => FlSpot(index.toDouble(), data[index].revenue),
                ),
                isCurved: true,
                barWidth: 2,
                color: AppColors.primary,
                dotData: FlDotData(show: false),
                preventCurveOverShooting: true,
                preventCurveOvershootingThreshold: 10,
                isStrokeCapRound: true,
                isStrokeJoinRound: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
