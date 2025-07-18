import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_text_styles.dart';

class WidgetSellerItemCardStatistic extends StatelessWidget {
  final ObjectItem item;
  const WidgetSellerItemCardStatistic({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.vanillaIce,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
            child: Container(
              height: 80,
              width: 80,
              color: Colors.amber,
              child: Image(image: item.images[0]),
            ),
          ),
          const SizedBox(width: 16),
          Text(item.itemName, style: AppTextStyles.title2),
          const Spacer(),
          Text(item.itemSold.toString(), style: AppTextStyles.title2),
        ],
      ),
    );
  }
}
