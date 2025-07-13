import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';

class ObjectNotification {
  final String notification;
  final String? description;
  final ObjectShop? shop;
  final ObjectItem? item;

  const ObjectNotification({
    required this.notification,
    this.description,
    this.item,
    this.shop,
  });
}