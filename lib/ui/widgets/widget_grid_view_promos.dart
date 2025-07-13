import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/ui/widgets/widget_item_card.dart';

class WidgetGridViewPromos extends StatelessWidget {
  final List<ObjectItem> itemList;
  final double paddings;
  const WidgetGridViewPromos({super.key, this.paddings = 0, required this.itemList});

  @override
  Widget build(BuildContext context) {
    // SHUFFLE
    itemList.shuffle();

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
        itemBuilder: (context, index) => WidgetItemCard(item: itemList[index],),
        itemCount: itemList.length,
      ),
    );
  }
}
