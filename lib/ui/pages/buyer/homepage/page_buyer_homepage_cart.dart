import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/bloc/buyer_account_bloc.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/global/saves/saves.dart';
import 'package:luma/ui/pages/buyer/page_buyer_purchase.dart';
import 'package:luma/ui/widgets/widget_shop_cart_item.dart';

class PageBuyerHomepageCart extends StatelessWidget {
  const PageBuyerHomepageCart({super.key});

  @override
  Widget build(BuildContext context) {
    // SHUFFLE
    List<ObjectItem> items = SaveLists.itemList;
    items.shuffle();

    return BlocBuilder<BuyerAccountBloc, BuyerAccountState>(
      builder: (context, state) {
        if (state is! BuyerAccountLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.actualOrders.isEmpty) {
          return const Center(
            child: Text(
              "Похоже тут пока ничего нет",
              style: AppTextStyles.title2,
            ),
          );
        }

        return Stack(
          children: [
            ListView.separated(
              itemBuilder: (context, index) {
                return WidgetShopCartItem(item: state.actualOrders[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(),
              itemCount: state.actualOrders.length,
            ),

            WidgetBottomButton(),
          ],
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
