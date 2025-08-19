import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_settings.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/widget_tag.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(AppSettings.borderAngle),
              ),

              child: Container(color: Colors.amber, width: 70, height: 70),
            ),

            const SizedBox(width: 12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Элегантное платье с поясом",
                  style: AppTextStyles.shopCartDescription,
                ),
                Row(
                  children: [
                    WidgetTag(text: "M"),
                    const SizedBox(width: 4),
                    WidgetTag(text: "Черный"),
                  ],
                ),
                Row(
                  children: [
                    Text("250,000 сум", style: AppTextStyles.itemPrice),
                    const SizedBox(width: 4),
                    Text("350,000 сум", style: AppTextStyles.itemSale),
                  ],
                ),
              ],
            ),

            const Spacer(),
          ],
        ),

        Align(
          alignment: Alignment.centerRight,
          child: QuantitySelector(
            count: 1,
            onAdd: () {},
            onDelete: () {},
            onRemove: () {},
          ),
        ),
      ],
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final int count;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const QuantitySelector({
    super.key,
    required this.count,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 28,
          height: 28,
          child: IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: AppColors.mainColor,
              size: 12,
            ),
            onPressed: onDelete,
          ),
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: IconButton(
                style: AppButtonStyle.iconButton,
                padding: EdgeInsets.zero,
                iconSize: 14,
                onPressed: onRemove,
                icon: Icon(Icons.remove, color: AppColors.inactiveBorderColor),
              ),
            ),

            const SizedBox(width: 12),

            Text("$count", style: AppTextStyles.shopCartDescription),

            const SizedBox(width: 12),

            SizedBox(
              width: 28,
              height: 28,
              child: IconButton(
                style: AppButtonStyle.iconButton,
                padding: EdgeInsets.zero,
                iconSize: 14,
                onPressed: onAdd,
                icon: Icon(Icons.add, color: AppColors.inactiveBorderColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
