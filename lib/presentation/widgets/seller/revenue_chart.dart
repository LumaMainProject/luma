import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/data/models/revenue_point.dart';

class RevenueChart extends StatelessWidget {
  final List<RevenuePoint> data;
  final List<RevenuePoint>? dataSecond;
  final List<RevenuePoint>? dataThird;

  const RevenueChart({
    super.key,
    required this.data,
    this.dataSecond,
    this.dataThird,
  });

  @override
  Widget build(BuildContext context) {
    List<LineChartBarData> dataStash = [
      _buildLine(data, AppColors.primary),
      if (dataSecond != null) _buildLine(dataSecond!, AppColors.secondary),
      if (dataThird != null) _buildLine(dataThird!, AppColors.third),
    ];

    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false), // убрали сетку
            borderData: FlBorderData(show: false), // убрали рамки
            titlesData: FlTitlesData(
              topTitles: AxisTitles(),
              leftTitles: AxisTitles(),
            ),
            lineBarsData: dataStash,
            minY: 0, // график не уходит ниже нуля
          ),
        ),
      ),
    );
  }

  LineChartBarData _buildLine(List<RevenuePoint> points, Color color) {
    return LineChartBarData(
      spots: List.generate(
        points.length,
        (index) => FlSpot(index.toDouble(), points[index].revenue),
      ),
      isCurved: true,
      barWidth: 2,
      color: color,
      dotData: FlDotData(show: false),
      preventCurveOverShooting: true,
      preventCurveOvershootingThreshold: 10,
      isStrokeCapRound: true,
      isStrokeJoinRound: true,
    );
  }
}
