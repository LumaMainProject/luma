import 'package:flutter/material.dart';
import 'package:luma/global/params/app_text_styles.dart';

class WidgetSellerItemCardStatistic extends StatelessWidget {
  const WidgetSellerItemCardStatistic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: BoxBorder.all(),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        children: [
          Container(height: 80, width: 80, color: Colors.amber),
          const SizedBox(width: 16),
          const Text("Item", style: AppTextStyles.title2),
          const Spacer(),
          const Text("Statistic", style: AppTextStyles.title2),
        ],
      ),
    );
  }
}
