import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_router.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/cart_shop_widget.dart';

class PageBuyerCart extends StatelessWidget {
  const PageBuyerCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Корзина", style: AppTextStyles.secondTitle),
        centerTitle: true,
      ),

      body: Stack(
        children: [
          ListView.separated(
            padding: EdgeInsets.all(10),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) =>
                index != 4 ? CartShopWidget() : const SizedBox(height: 180),
            itemCount: 5,
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: AppButtonStyle.customBottomNavBar,
              margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 10),
              height: 80,

              child: Container(
                decoration: AppButtonStyle.customBottomNavBarFix,
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("ИТОГО", style: AppTextStyles.itemBigTitle),
                        Text("280.000 сум", style: AppTextStyles.itemBigTitle),
                      ],
                    ),

                    const Spacer(),

                    TextButton(
                      style: AppButtonStyle.textMajorButton,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRouter.names[AppRouterEnum
                              .routerBuyerFinalizeOrder]!,
                        );
                      },
                      child: Text(
                        "Оформить заказ",
                        style: AppTextStyles.textButtonMajor,
                      ),
                    ),
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
