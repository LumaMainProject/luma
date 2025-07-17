import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/buyer_bloc/buyer_account_bloc.dart';
import 'package:luma/domain/store_manager_bloc/store_manager_bloc.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/global/saves/saves.dart';
import 'package:luma/ui/pages/buyer/page_buyer_purchase.dart';
import 'package:luma/ui/widgets/widget_shop_item_stack.dart';

class PageBuyerHomepageCart extends StatelessWidget {
  const PageBuyerHomepageCart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreManagerBloc, StoreManagerState>(
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

            if (state.actualOrders.isEmpty) {
              return const Center(
                child: Text(
                  "Похоже тут пока ничего нет",
                  style: AppTextStyles.title2,
                ),
              );
            }

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

            // int length = 0;
            // List<String> exclude = [];

            // for (ObjectItem element in buyerAccountLoaded.actualOrders) {
            //   if (!exclude.contains(element.brand)) {
            //     exclude.add(element.brand);
            //     length++;
            //   }
            // }

            return Stack(
              children: [
                ListView.separated(
                  itemBuilder: (context, index) {
                    if (index == objectShop.length) {
                      return const SizedBox(height: 60);
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: WidgetShopItemStack(
                          item: buyerAccountLoaded.actualOrders,
                          shop: objectShop[index],
                          itemToShopDictionary:
                              storeManagerLoaded.itemToShopDictionary,
                        ),
                      // child: WidgetShopItemStack(
                      //   item: buyerAccountLoaded.actualOrders,
                      //   shop:
                      //       storeManagerLoaded
                      //           .itemToShopDictionary[buyerAccountLoaded
                      //           .actualOrders[index]] ??
                      //       SaveShop.adidas,
                      //   itemToShopDictionary:
                      //       storeManagerLoaded.itemToShopDictionary,
                      // ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemCount: objectShop.length + 1,
                ),

                WidgetBottomButton(),
              ],
            );
          },
        );
      },
    );
  }
}

class WidgetBottomButton extends StatelessWidget {
  const WidgetBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: FilledButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PageBuyerPurchase(),
                ),
              );
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(16),
              ),
            ),
            child: Text("Buy", style: AppTextStyles.title),
          ),
        ),
      ),
    );
  }
}
