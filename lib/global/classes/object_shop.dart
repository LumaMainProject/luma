import 'package:flutter/widgets.dart';
import 'package:luma/global/classes/object_item.dart';

class ObjectShop {
  final String shopName;
  final AssetImage icon;
  final AssetImage header;
  final List<ObjectItem>? items;

  const ObjectShop({
    required this.shopName,
    required this.icon,
    required this.header,
    this.items,
  });
}
