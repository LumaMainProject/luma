import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/buyer_bloc/buyer_account_bloc.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/params/app_colors.dart';
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
    final ObjectItem item = widget.item;
    final bloc = BlocProvider.of<BuyerAccountBloc>(context);
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
      floatingActionButton: BlocBuilder<BuyerAccountBloc, BuyerAccountState>(
        builder: (context, state) {
          if (state is! BuyerAccountLoaded) {
            return const SizedBox();
          }

          if (state.actualOrders.contains(item)) {
            return Container(
              width: 140,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadiusDirectional.all(Radius.circular(16)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      bloc.add(RemoveActualOrdersEvent(item: item));
                      setState(() {});
                    },
                  ),
                  const SizedBox(width: 16),
                  Text(state.actualOrdersItemAmount(item).toString()),
                  const SizedBox(width: 16),
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                    onPressed: () {
                      bloc.add(AddActualOrdersEvent(item: item));
                      setState(() {});
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton.filled(
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
                onPressed: () {
                  bloc.add(AddActualOrdersEvent(item: item));
                  setState(() {});
                },
                icon: Icon(Icons.add),
              ),
            ],
          );
        },
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
                children: List.generate(
                  item.images.length,
                  (index) => ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: Image(fit: BoxFit.fill, image: item.images[index]),
                  ),
                ),
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
                        Text(item.itemName, style: AppTextStyles.title),
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

                    WidgetStore(store: item.shop),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Brand", style: AppTextStyles.title2),
                        Text(item.brand, style: AppTextStyles.title2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Price", style: AppTextStyles.title2),
                        Text(
                          item.price.toString(),
                          style: AppTextStyles.title2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Size", style: AppTextStyles.title2),
                        Text(item.size, style: AppTextStyles.title2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quantity", style: AppTextStyles.title2),
                        Text(
                          item.quantity.toString(),
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
