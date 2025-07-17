import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/buyer_bloc/buyer_account_bloc.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/pages/buyer/page_buyer_homepage.dart';
import 'package:luma/ui/widgets/widget_store.dart';

class PageBuyerItemCard extends StatefulWidget {
  final ObjectShop shop;
  final ObjectItem item;
  final Map<ObjectItem, ObjectShop> itemToShopDictionary;
  const PageBuyerItemCard({
    super.key,
    required this.shop,
    required this.item,
    required this.itemToShopDictionary,
  });

  @override
  State<PageBuyerItemCard> createState() => _PageBuyerItemCardState();
}

class _PageBuyerItemCardState extends State<PageBuyerItemCard> {
  CarouselController carouselController = CarouselController();
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final ObjectItem item = widget.item;
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

      // floatingActionButton: BlocBuilder<BuyerAccountBloc, BuyerAccountState>(
      //   builder: (context, state) {
      //     if (state is! BuyerAccountLoaded) {
      //       return const SizedBox();
      //     }

      //     return PageBuyerItemCardButtons();
      //   },
      // ),
      body: Stack(
        children: [
          CustomScrollView(
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
                        child: Image(
                          fit: BoxFit.fill,
                          image: item.images[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.all(
                      Radius.circular(16),
                    ),
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

                        WidgetStore(
                          store: widget.shop,
                          itemToShopDictionary: widget.itemToShopDictionary,
                        ),

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

                        const Divider(),

                        Text("Desctiption", style: AppTextStyles.title),
                        Text(
                          style: AppTextStyles.description,
                          item.desctiption,
                        ),
                        Text(
                          style: AppTextStyles.description,
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        ),
                        Text(
                          style: AppTextStyles.description,
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: PageBuyerItemCardButtons(item: widget.item),
            ),
          ),
        ],
      ),
    );
  }
}

class PageBuyerItemCardButtons extends StatelessWidget {
  final ObjectItem item;
  const PageBuyerItemCardButtons({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BuyerAccountBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppColors.vanillaIce,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
            ),
            onPressed: () {
              bloc.add(AddActualOrdersEvent(item: item));
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => PageBuyerHomepage(pageIndex: 2),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: Text("Купить сейчас", style: AppTextStyles.title),
          ),
        ),

        const SizedBox(height: 4),

        WidgetPageBuyerItemCardAddToCardButton(item: item),
      ],
    );
  }
}

class WidgetPageBuyerItemCardAddToCardButton extends StatefulWidget {
  final ObjectItem item;
  const WidgetPageBuyerItemCardAddToCardButton({super.key, required this.item});

  @override
  State<WidgetPageBuyerItemCardAddToCardButton> createState() =>
      _WidgetPageBuyerItemCardAddToCardButtonState();
}

class _WidgetPageBuyerItemCardAddToCardButtonState
    extends State<WidgetPageBuyerItemCardAddToCardButton> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BuyerAccountBloc>(context);
    return BlocBuilder<BuyerAccountBloc, BuyerAccountState>(
      builder: (context, state) {
        if (state is! BuyerAccountLoaded) {
          return const SizedBox();
        }

        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppColors.vanillaIce,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: !state.actualOrders.contains(widget.item)
              ? TextButton(
                  onPressed: () {
                    bloc.add(AddActualOrdersEvent(item: widget.item));
                    setState(() {});
                  },
                  child: Text("Добавить в корзину", style: AppTextStyles.title),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width / 3,
                          50,
                        ),
                      ),
                      onPressed: () {
                        bloc.add(RemoveActualOrdersEvent(item: widget.item));
                        setState(() {});
                      },
                      child: Icon(Icons.remove, size: 32),
                    ),
                    Text(
                      state.actualOrdersItemAmount(widget.item).toString(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(32),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width / 3,
                          50,
                        ),
                      ),
                      onPressed: () {
                        bloc.add(AddActualOrdersEvent(item: widget.item));
                        setState(() {});
                      },
                      child: Icon(Icons.add, size: 32),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
