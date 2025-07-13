import 'package:luma/global/classes/object_item.dart';

class ObjectShop {
  final String shopName;
  final String icon;
  final String header;
  final List<ObjectItem>? items;

  const ObjectShop({
    required this.shopName,
    required this.icon,
    required this.header,
    this.items,
  });
}
