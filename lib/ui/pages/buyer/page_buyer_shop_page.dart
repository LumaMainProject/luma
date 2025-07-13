import 'package:flutter/material.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/widget_grid_view_promos.dart';
import 'package:luma/ui/widgets/widget_grid_view_suggested.dart';

class PageBuyerShopPage extends StatelessWidget {
  const PageBuyerShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: Container(color: Colors.amber,),
          ),

          // REVIEWS AND FOLOWERS
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Shop Name", style: AppTextStyles.title),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Reviews", style: AppTextStyles.title2),
                      SizedBox(
                        child: Row(
                          children: [
                            Icon(Icons.star),
                            Icon(Icons.star),
                            Icon(Icons.star),
                            Icon(Icons.star),
                            Icon(Icons.star),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Followers", style: AppTextStyles.title2),
                      Text("3406", style: AppTextStyles.title2),
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
                  Placeholder(),
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
                  WidgetGridViewPromos(),
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
                  WidgetGridViewSuggested(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
