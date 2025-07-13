import 'package:flutter/material.dart';
import 'package:luma/ui/widgets/widget_item_card.dart';

class WidgetGridViewPromos extends StatelessWidget {
  final double paddings;
  const WidgetGridViewPromos({super.key, this.paddings = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: paddings),
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.2,
          mainAxisSpacing: 16,
          crossAxisCount: 1,
        ),
        itemBuilder: (context, index) => WidgetItemCard(),
        itemCount: 10,
      ),
    );
  }
}
