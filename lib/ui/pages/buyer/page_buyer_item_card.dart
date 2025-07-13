import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/global/saves/saves.dart';
import 'package:luma/ui/widgets/widget_grid_view_promos.dart';
import 'package:luma/ui/widgets/widget_store.dart';

class PageBuyerItemCard extends StatefulWidget {
  final ObjectItem item;
  const PageBuyerItemCard({super.key, required this.item});

  @override
  State<PageBuyerItemCard> createState() => _PageBuyerItemCardState();
}

class _PageBuyerItemCardState extends State<PageBuyerItemCard> {
  CarouselController carouselController = CarouselController();
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        // flexibleSpace: ClipRRect(
        //   borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        //     child: Container(color: Colors.transparent),
        //   ),
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(AppIcons.shopCart),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 400,
              child: CarouselView.weighted(
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide.none,
                ),
                enableSplash: false,
                itemSnapping: true,
                controller: carouselController,
                flexWeights: [1],
                children: [Placeholder(), Placeholder(), Placeholder()],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.all(Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(widget.item.itemName, style: AppTextStyles.title),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          icon: Icon(
                            color: isFavorite == true
                                ? AppColors.mainColor
                                : AppColors.borderColor,
                            isFavorite == true
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),

                    WidgetStore(store: widget.item.shop),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Brand", style: AppTextStyles.title2),
                        Text(widget.item.brand, style: AppTextStyles.title2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Price", style: AppTextStyles.title2),
                        Text(
                          widget.item.price.toString(),
                          style: AppTextStyles.title2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Size", style: AppTextStyles.title2),
                        Text(widget.item.size, style: AppTextStyles.title2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quantity", style: AppTextStyles.title2),
                        Text(
                          widget.item.quantity.toString(),
                          style: AppTextStyles.title2,
                        ),
                      ],
                    ),

                    const Divider(),

                    Text("Desctiption", style: AppTextStyles.title),
                    Text(
                      style: AppTextStyles.description,
                      widget.item.desctiption,
                    ),
                    Text(
                      style: AppTextStyles.description,
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    ),
                    Text(
                      style: AppTextStyles.description,
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    ),
                    Text(
                      style: AppTextStyles.description,
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    ),

                    Placeholder(),
                    SizedBox(height: 16),
                    WidgetGridViewPromos(itemList: SaveLists.itemList),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
