import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/ui/widgets/widget_item_card.dart';

class WidgetGridViewSuggested extends StatelessWidget {
  final List<ObjectItem> itemList;
  final Map<ObjectItem, ObjectShop> itemToShopDictionary;
  final bool isSeller;
  const WidgetGridViewSuggested({
    super.key,
    required this.itemList,
    required this.itemToShopDictionary,
    this.isSeller = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: .8,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) => WidgetItemCard(
        index: index,
        item: itemList[index],
        itemToShopDictionary: itemToShopDictionary,
        isSeller: isSeller,
      ),
      itemCount: itemList.length,
    );
  }
}
