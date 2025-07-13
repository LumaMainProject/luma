import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_shop.dart';

class ObjectItem {
  final String itemName;
  final String desctiption;
  final String size;
  final String brand;
  final int reviews;
  final double price;
  final double quantity;
  final ObjectShop shop;
  final List<AssetImage> images;

  const ObjectItem({
    required this.itemName,
    required this.desctiption,
    required this.size,
    required this.images,
    required this.shop,
    required this.brand,
    required this.price,
    required this.quantity,
    required this.reviews,
  });
}
