import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/ui/pages/buyer/page_buyer_shop_page.dart';

class WidgetStore extends StatelessWidget {
  final double blurLevel;
  final String storeName;
  const WidgetStore({
    super.key,
    this.blurLevel = 0,
    this.storeName = "Default Store Name",
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadiusGeometry.all(Radius.circular(16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurLevel, sigmaY: blurLevel),
        child: ListTile(
          leading: const Icon(AppIcons.account),
          title: Text(storeName),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PageBuyerShopPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
