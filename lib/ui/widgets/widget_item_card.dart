import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/ui/pages/buyer/page_buyer_shop_page.dart';

class WidgetItemCard extends StatelessWidget {
  final ObjectItem item;
  const WidgetItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(16),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageBuyerShopPage(shop: item.shop),
              ),
            );
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadiusDirectional.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(item.itemName),
              Text(item.price.toString()),
              SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
