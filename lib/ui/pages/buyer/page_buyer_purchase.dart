import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/buyer_bloc/buyer_account_bloc.dart';
import 'package:luma/domain/store_manager_bloc/store_manager_bloc.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/global/saves/saves.dart';
import 'package:luma/ui/widgets/widget_shop_item_stack.dart';

class PageBuyerPurchase extends StatelessWidget {
  const PageBuyerPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StoreManagerBloc, StoreManagerState>(
        builder: (context, state) {
          if (state is! StoreManagerLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          StoreManagerLoaded storeManagerLoaded = state;

          return BlocBuilder<BuyerAccountBloc, BuyerAccountState>(
            builder: (context, state) {
              if (state is! BuyerAccountLoaded) {
                return const Center(child: CircularProgressIndicator());
              }

              BuyerAccountLoaded buyerAccountLoaded = state;

              List<ObjectShop> objectShop = [];

              for (ObjectItem item in buyerAccountLoaded.actualOrders) {
                if (!objectShop.contains(
                  storeManagerLoaded.itemToShopDictionary[item],
                )) {
                  objectShop.add(
                    storeManagerLoaded.itemToShopDictionary[item] ??
                        SaveShop.adidas,
                  );
                }
              }

              return CustomScrollView(
                slivers: [
                  SliverAppBar(title: Text("Checkout")),

                  SliverList.separated(
                    itemCount: objectShop.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: WidgetShopItemStack(
                          item: buyerAccountLoaded.actualOrders,
                          shop: objectShop[index],
                          itemToShopDictionary:
                              storeManagerLoaded.itemToShopDictionary,
                        ),
                      );
                    },
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Total ${state.actualOrdersTotalPrice()}",
                            style: AppTextStyles.title,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // SliverToBoxAdapter(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16),
                  //     child: Placeholder(),
                  //   ),
                  // ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FilledButton(
                            onPressed: () {},
                            child: const Text("Быстрая"),
                          ),
                          FilledButton(
                            onPressed: () {},
                            child: const Text("Экспресс"),
                          ),
                          FilledButton(
                            onPressed: () {},
                            child: const Text("Обычная"),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Товар", style: AppTextStyles.description),
                              Text(
                                "Доставка",
                                style: AppTextStyles.description,
                              ),
                              Text(
                                "Комиссия",
                                style: AppTextStyles.description,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${state.actualOrdersTotalPrice()}",
                                style: AppTextStyles.description,
                              ),
                              const Text(
                                "5000",
                                style: AppTextStyles.description,
                              ),
                              const Text(
                                "10000",
                                style: AppTextStyles.description,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Total", style: AppTextStyles.title),
                          const SizedBox(width: 16),
                          Text(
                            "${state.actualOrdersTotalPrice() + 15000}",
                            style: AppTextStyles.title,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "PayMe",
                                  style: AppTextStyles.title2,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Click",
                                  style: AppTextStyles.title2,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Uzum",
                                  style: AppTextStyles.title2,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}


