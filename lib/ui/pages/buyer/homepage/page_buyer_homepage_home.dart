import 'package:flutter/material.dart';
import 'package:luma/global/app_icons.dart';
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

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: WidgetGridViewPromos(),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text("New Arrivals", style: TextStyle(fontSize: 18)),
      ),

      debug == true ? Placeholder() : WidgetCarouselView(),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text("Suggested for You", style: TextStyle(fontSize: 18)),
      ),

      Padding(
        padding: const EdgeInsets.all(16),
        child: WidgetGridViewSuggested(),
      ),
    ];

    return ListView.separated(
      itemBuilder: (context, index) => items[index],
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: items.length,
    );
  }
}
