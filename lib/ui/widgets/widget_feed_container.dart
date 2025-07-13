import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/ui/pages/buyer/page_buyer_item_card.dart';
import 'package:luma/ui/widgets/widget_store.dart';

class WidgetFeedContainer extends StatelessWidget {
  final ObjectShop shop;
  final ObjectItem item;
  const WidgetFeedContainer({
    super.key,
    required this.shop,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        border: BoxBorder.all(),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Stack(
        children: [
          // VIDEO
          SizedBox(
            child: Center(child: Image(image: shop.header)),
          ),

          // ITEM
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5, sigmaY: 5
                ),
                child: Container(
                  color: Colors.black12,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
                    ),
                    leading: Icon(AppIcons.account),
                    title: Text(item.itemName),
                    subtitle: Text(item.brand),
                    trailing: Text(item.price.toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageBuyerItemCard(item: item),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          //STORE
          Align(
            alignment: Alignment.topCenter,
            child: WidgetStore(blurLevel: 5, store: shop,),
          ),
        ],
      ),
    );
  }
}
