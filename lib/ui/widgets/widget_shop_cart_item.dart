import 'package:flutter/material.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/widget_store.dart';

class WidgetShopCartItem extends StatelessWidget {
  const WidgetShopCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.all(Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetStore(),

          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(color: Colors.amber, height: 120, width: 120),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Brand", style: AppTextStyles.title2),
                        Text("Adidas", style: AppTextStyles.title2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Price", style: AppTextStyles.title2),
                        Text("299", style: AppTextStyles.title2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Size", style: AppTextStyles.title2),
                        Text("23", style: AppTextStyles.title2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quantity", style: AppTextStyles.title2),
                        Text("111", style: AppTextStyles.title2),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Text("Final Price", style: AppTextStyles.title),
          ),
        ],
      ),
    );
  }
}
