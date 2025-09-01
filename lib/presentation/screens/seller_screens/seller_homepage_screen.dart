import 'package:flutter/material.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_homepage_screen/seller_homepage_screen_account.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_homepage_screen/seller_homepage_screen_analitics.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_homepage_screen/seller_homepage_screen_content.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_homepage_screen/seller_homepage_screen_orders.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_homepage_screen/seller_homepage_screen_products.dart';
import 'package:luma_2/presentation/widgets/buyer/custom_nav_bar.dart';

class SellerHomepageScreen extends StatefulWidget {
  const SellerHomepageScreen({super.key});

  @override
  State<SellerHomepageScreen> createState() => _SellerHomepageScreenState();
}

class _SellerHomepageScreenState extends State<SellerHomepageScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    SellerHomepageScreenContent(),
    SellerHomepageScreenProducts(),
    SellerHomepageScreenOrders(),
    SellerHomepageScreenAnalitics(),
    SellerHomepageScreenAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Текущая страница
          pages[selectedIndex],

          Align(
            alignment: Alignment.bottomCenter,
            child: CustomNavBar(
              icons: [
                AppIcons.sellerHomepage,
                AppIcons.sellerProducts,
                AppIcons.sellerOrders,
                AppIcons.sellerAnalitics,
                AppIcons.sellerAccount,
              ],
              selectedIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
