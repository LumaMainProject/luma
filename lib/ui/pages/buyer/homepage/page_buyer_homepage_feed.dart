import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/saves/saves.dart';
import 'package:luma/ui/widgets/widget_feed_container.dart';

class PageBuyerHomepageFeed extends StatelessWidget {
  const PageBuyerHomepageFeed({super.key});

  @override
  Widget build(BuildContext context) {
    List<ObjectItem> list = SaveLists.itemList;
    CarouselController carouselController = CarouselController();
    return CarouselView.weighted(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      controller: carouselController,
      flexWeights: [1],
      scrollDirection: Axis.vertical,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.zero),
        borderSide: BorderSide.none,
      ),
      itemSnapping: true,
      enableSplash: false,

      children: List.generate(
        list.length,
        (index) =>
            WidgetFeedContainer(shop: list[index].shop, item: list[index]),
      ),
    );
  }
}
