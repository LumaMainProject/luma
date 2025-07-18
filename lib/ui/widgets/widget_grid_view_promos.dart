import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/ui/widgets/widget_item_card.dart';

class WidgetGridViewPromos extends StatelessWidget {
  final List<ObjectItem> itemList;
  final Map<ObjectItem, ObjectShop> itemToShopDictionary;
  final double paddings;
  final bool isSeller;
  const WidgetGridViewPromos({
    super.key,
    this.paddings = 0,
    this.isSeller = false,
    required this.itemList,
    required this.itemToShopDictionary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: paddings),
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.4,
          mainAxisSpacing: 16,
          crossAxisCount: 1,
        ),
        itemBuilder: (context, index) => WidgetItemCard(
          index: index,
          item: itemList[index],
          itemToShopDictionary: itemToShopDictionary,
          isSeller: isSeller,
        ),
        itemCount: itemList.length,
      ),
    );
  }
}
