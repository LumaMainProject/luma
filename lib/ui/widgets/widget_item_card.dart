import 'package:flutter/material.dart';
import 'package:luma/global/app_colors.dart';
import 'package:luma/ui/pages/buyer/page_buyer_item_card.dart';

class WidgetItemCard extends StatelessWidget {
  const WidgetItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PageBuyerItemCard()),
        );
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(0),
        side: BorderSide(width: 1, color: AppColors.borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      child: Column(
        children: [
          // IMAGE
          Icon(Icons.accessibility_outlined),
          Spacer(),
          Divider(color: AppColors.borderColor),
          Text("Name", maxLines: 1),
          Text("Price", maxLines: 1),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
