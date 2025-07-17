import 'package:flutter/widgets.dart';
import 'package:luma/global/classes/object_item.dart';

class ObjectShop {
  final String shopName;
  final AssetImage icon;
  final AssetImage header;
  final int? rating;
  final int followers;
  final List<ObjectItem> items;
  final String video;

  const ObjectShop({
    required this.shopName,
    required this.icon,
    required this.header,
    required this.video,
    required this.items,
    this.followers = 0,
    this.rating,
  });
}
