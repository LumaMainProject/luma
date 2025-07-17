import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/widget_store.dart';

class WidgetShopItemStack extends StatelessWidget {
  final ObjectShop shop;
  final List<ObjectItem> item;
  final Map<ObjectItem, ObjectShop> itemToShopDictionary;
  const WidgetShopItemStack({
    super.key,
    required this.item,
    required this.shop,
    required this.itemToShopDictionary,
  });

  @override
  Widget build(BuildContext context) {
    Map<ObjectItem, int> stackItems = {};

    for (ObjectItem element in item) {
      if (itemToShopDictionary[element] == shop) {
        if (!stackItems.containsKey(element)) {
          stackItems[element] = 0;
        }

        stackItems[element] = stackItems[element]! + 1;
      }
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.vanillaIce,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),

      child: Column(
        children: [
          WidgetStore(
            store: shop,
            color: AppColors.mainColor,
            itemToShopDictionary: itemToShopDictionary,
          ),

          const SizedBox(height: 16),

          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return WidgetShopItemStackItem(
                item: item[index],
                amount: stackItems[item[index]] ?? 1,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemCount: stackItems.length,
          ),
        ],
      ),
    );
  }
}

class WidgetShopItemStackItem extends StatelessWidget {
  final ObjectItem item;
  final int amount;
  const WidgetShopItemStackItem({
    super.key,
    required this.item,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadiusGeometry.all(Radius.circular(16)),
          child: Image(
            image: item.images[0],
            fit: BoxFit.fill,
            width: 80,
            height: 80,
          ),
        ),

        const SizedBox(width: 16),

        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(item.price.toString(), style: AppTextStyles.title),
              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: Text(
                  item.itemName,
                  style: AppTextStyles.title,
                  maxLines: 1,
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Price", style: AppTextStyles.title2),
                    Text(item.price.toString(), style: AppTextStyles.title2),
                  ],
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: Row(
                  children: [
                    const Spacer(),

                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove, color: AppColors.vanillaIce),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Text(amount.toString(), style: AppTextStyles.title2),

                    const SizedBox(width: 16),

                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add, color: AppColors.vanillaIce),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
