import 'package:flutter/material.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/global/saves/saves.dart';
import 'package:luma/ui/widgets/widger_carousel_view.dart';
import 'package:luma/ui/widgets/widget_grid_view_promos.dart';
import 'package:luma/ui/widgets/widget_grid_view_suggested.dart';

class PageBuyerHomepageHome extends StatelessWidget {
  const PageBuyerHomepageHome({super.key});

  @override
  Widget build(BuildContext context) {
    final bool debug = true;
    final List<Widget> items = [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text("Promos", style: TextStyle(fontSize: 18)),
            IconButton(onPressed: () {}, icon: Icon(AppIcons.rightArrow)),
          ],
        ),
      ),

      WidgetGridViewPromos(paddings: 16, itemList: SaveLists.itemList),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text("New Arrivals", style: TextStyle(fontSize: 18)),
      ),

      debug == true
          ? WidgetGridViewPromos(paddings: 16, itemList: SaveLists.itemList)
          : WidgetCarouselView(itemList: SaveLists.itemList),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text("Suggested for You", style: TextStyle(fontSize: 18)),
      ),

      Padding(
        padding: const EdgeInsets.all(16),
        child: WidgetGridViewSuggested(itemList: SaveLists.itemList),
      ),
    ];

    return ListView.separated(
      itemBuilder: (context, index) => items[index],
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: 6,
    );
  }
}
