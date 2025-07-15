import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/ui/pages/buyer/page_buyer_shop_page.dart';

class WidgetStore extends StatelessWidget {
  final ObjectShop store;
  final double blurLevel;
  const WidgetStore({super.key, this.blurLevel = 0, required this.store});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadiusGeometry.all(Radius.circular(16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurLevel, sigmaY: blurLevel),
        child: Container(
          color: Colors.black12,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: const BorderRadiusGeometry.all(Radius.circular(16)),
              child: Image(fit: BoxFit.cover, image: store.header, height: 50, width: 50,),
            ),
            title: Text(store.shopName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageBuyerShopPage(shop: store),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
