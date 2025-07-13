import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/ui/pages/buyer/page_buyer_item_card.dart';

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
                builder: (context) => PageBuyerItemCard(item: item),
              ),
            );
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadiusDirectional.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius:  BorderRadiusDirectional.circular(16),
                    child: Image(fit: BoxFit.cover, image: item.images[0]),
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
