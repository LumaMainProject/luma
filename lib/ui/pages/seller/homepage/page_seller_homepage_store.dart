import 'package:flutter/material.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/widget_grid_view_promos.dart';
import 'package:luma/ui/widgets/widget_grid_view_suggested.dart';

class PageSellerHomepageStore extends StatelessWidget {
  const PageSellerHomepageStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageSellerHomepageStoreSliver(),
        PageSellerHomepageStoreEditAndAdd(),
      ],
    );
  }
}

class PageSellerHomepageStoreEditAndAdd extends StatelessWidget {
  const PageSellerHomepageStoreEditAndAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ))
            ),
            child: Row(
              children: [
                Text("Edit", style: AppTextStyles.title2),
              ],
            ),
          ),

          SizedBox(width: 4),

          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ))
            ),
            child: Row(
              children: [
                Text("Add", style: AppTextStyles.title2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PageSellerHomepageStoreSliver extends StatelessWidget {
  const PageSellerHomepageStoreSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: SizedBox(),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
          ],
          expandedHeight: 300,
          flexibleSpace: Container(color: Colors.amber),
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
    );
  }
}
