import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/widget_store.dart';

class WidgetShopCartItem extends StatelessWidget {
  final ObjectItem item;
  const WidgetShopCartItem({super.key, required this.item});

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
          WidgetStore(store: item.shop),

          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                color: Colors.amber,
                height: 120,
                width: 120,
                child: Image(fit: BoxFit.fill, image: item.images[0]),
              ),
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
                  ],
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Text(item.price.toString(), style: AppTextStyles.title),
          ),
        ],
      ),
    );
  }
}
