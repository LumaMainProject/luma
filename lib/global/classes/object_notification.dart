import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/params/app_notifications_status.dart';

class ObjectNotification {
  final int amount;
  final AppNotificationsStatus status;
  final ObjectShop shop;
  final ObjectItem item;
  final DateTime? time;

  const ObjectNotification({
    required this.amount,
    required this.status,
    required this.item,
    required this.shop,
    this.time,
  });
}