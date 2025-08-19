import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_settings.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/cart_item_widget.dart';

class CartShopWidget extends StatelessWidget {
  const CartShopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppButtonStyle.cartShopWidget,

      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.cartCard,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSettings.borderAngle),
                topRight: Radius.circular(AppSettings.borderAngle),
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: Container(color: Colors.amber, width: 35, height: 35),
                ),

                const SizedBox(width: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Fashion Co", style: AppTextStyles.text),
                    Text("1 товар", style: AppTextStyles.textButtonMinor),
                  ],
                ),

                const Spacer(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("265.000 сум", style: AppTextStyles.itemBigPrice),
                    Text("с доставкой", style: AppTextStyles.textButtonMinor),
                  ],
                ),
              ],
            ),
          ),

          ListView.separated(
            itemBuilder: (context, index) => CartItemWidget(),
            separatorBuilder: (context, index) => const SizedBox(height: 14),
            padding: EdgeInsets.all(14),
            itemCount: 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),

          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.cartCard,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppSettings.borderAngle),
                bottomRight: Radius.circular(AppSettings.borderAngle),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Товары", style: AppTextStyles.shopCartTitle),
                    Text("Доставка", style: AppTextStyles.shopCartTitle),
                    Text(
                      "До бесплатной доставки: 50.000 сум",
                      style: AppTextStyles.shopCartDelivery,
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "250.000 сум",
                      style: AppTextStyles.shopCartDescription,
                    ),
                    Text(
                      "15.000 сум",
                      style: AppTextStyles.shopCartDescription,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
