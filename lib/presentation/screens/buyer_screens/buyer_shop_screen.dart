import 'package:flutter/material.dart';
import 'package:luma_2/data/models/store.dart';

class BuyerShopScreen extends StatelessWidget {
  final Store store;
  const BuyerShopScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(store.name)));
  }
}
