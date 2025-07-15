import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_notification.dart';
import 'package:luma/global/classes/object_shop.dart';

enum Gender {
  male,
  female
}

class ObjectUser {
  final int number;
  final Gender gender;

  final String? name;
  final String? avatar;
  final String? email;

  final List<String>? creditCard;
  final List<String>? addresses;

  final List<ObjectItem>? historyOrders;
  final List<ObjectItem>? actualOrders;

  final List<ObjectShop>? shopSubscriptions;
  final List<ObjectNotification>? notifications;

  final bool isSeller;

  const ObjectUser({
    required this.number,
    required this.gender,
    required this.isSeller,

    this.addresses,
    this.avatar,
    this.creditCard,
    this.email,
    this.historyOrders,
    this.actualOrders,
    this.name,
    this.notifications,
    this.shopSubscriptions,
  });
}
