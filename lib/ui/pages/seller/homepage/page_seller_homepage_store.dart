import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/store_manager_bloc/store_manager_bloc.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/widget_grid_view_promos.dart';
import 'package:luma/ui/widgets/widget_grid_view_suggested.dart';

class PageSellerHomepageStore extends StatelessWidget {
  final ObjectShop shop;
  const PageSellerHomepageStore({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageSellerHomepageStoreSliver(shop: shop),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
            ),
            child: Row(children: [Text("Edit", style: AppTextStyles.title2)]),
          ),

          SizedBox(width: 4),

          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
            ),
            child: Row(children: [Text("Add", style: AppTextStyles.title2)]),
          ),
        ],
      ),
    );
  }
}

class PageSellerHomepageStoreSliver extends StatelessWidget {
  final ObjectShop shop;
  const PageSellerHomepageStoreSliver({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreManagerBloc, StoreManagerState>(
      builder: (context, state) {
        if (state is! StoreManagerLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: Container(
                color: Colors.amber,
                child: Image(
                  fit: BoxFit.cover,
                  image: shop.header,
                  height: 300,
                ),
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
                    WidgetGridViewPromos(
                      itemList: state.itemsNewArrivals,
                      itemToShopDictionary: state.itemToShopDictionary,
                      isSeller: true,
                    ),
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
                    WidgetGridViewPromos(
                      itemList: state.itemsPromos,
                      itemToShopDictionary: state.itemToShopDictionary,
                      isSeller: true,
                    ),
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
                    WidgetGridViewSuggested(
                      itemList: state.itemsSuggested,
                      itemToShopDictionary: state.itemToShopDictionary,
                      isSeller: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
