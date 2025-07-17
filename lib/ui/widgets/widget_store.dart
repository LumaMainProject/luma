import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/ui/pages/buyer/page_buyer_shop_page.dart';

class WidgetStore extends StatelessWidget {
  final ObjectShop store;
  final double blurLevel;
  final Map<ObjectItem, ObjectShop> itemToShopDictionary;
  const WidgetStore({
    super.key,
    this.blurLevel = 0,
    required this.store,
    required this.itemToShopDictionary,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadiusGeometry.all(Radius.circular(16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurLevel, sigmaY: blurLevel),
        child: Container(
          color: AppColors.vanillaIce,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: const BorderRadiusGeometry.all(Radius.circular(16)),
              child: Image(
                fit: BoxFit.cover,
                image: store.header,
                height: 50,
                width: 50,
              ),
            ),
            title: Text(store.shopName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageBuyerShopPage(
                    shop: store,
                    itemToShopDictionary: itemToShopDictionary,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
