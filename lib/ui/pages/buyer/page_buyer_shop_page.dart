import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/global/saves/saves.dart';
import 'package:luma/ui/widgets/widget_grid_view_promos.dart';
import 'package:luma/ui/widgets/widget_grid_view_suggested.dart';

class PageBuyerShopPage extends StatelessWidget {
  final ObjectShop shop;
  const PageBuyerShopPage({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    List<ObjectItem> items = [];

    for (ObjectItem element in SaveLists.itemList) {
      if (element.shop == shop) items.add(element);
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: Container(
              color: Colors.amber,
              child: Image(fit: BoxFit.cover, image: shop.header, height: 300,),
            ),
          ),

          // REVIEWS AND FOLOWERS
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(shop.shopName, style: AppTextStyles.title),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Reviews", style: AppTextStyles.title2),
                      SizedBox(
                        child: Row(
                          children: List.generate(5, (index) {
                            return shop.rating == null
                                ? Text("No rating")
                                : shop.rating! >= index + 1
                                ? Icon(Icons.star)
                                : Icon(Icons.star_border);
                          }),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Followers", style: AppTextStyles.title2),
                      Text(
                        shop.followers.toString(),
                        style: AppTextStyles.title2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // BEST SELLER
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Best Seller", style: AppTextStyles.title),
                  SizedBox(height: 16),
                  WidgetGridViewPromos(itemList: items),
                ],
              ),
            ),
          ),

          // PROMOS
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Promos", style: AppTextStyles.title),
                  SizedBox(height: 16),
                  WidgetGridViewPromos(itemList: SaveLists.itemList),
                ],
              ),
            ),
          ),

          // ALL
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("All", style: AppTextStyles.title),
                  WidgetGridViewSuggested(itemList: SaveLists.itemList),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
