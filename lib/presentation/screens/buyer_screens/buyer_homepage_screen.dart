import 'package:flutter/material.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_homepage_screen/buyer_homepage_screen_account.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_homepage_screen/buyer_homepage_screen_content.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_homepage_screen/buyer_homepage_screen_player.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_homepage_screen/buyer_homepage_screen_shop.dart';
import 'package:luma_2/presentation/widgets/custom_nav_bar.dart';

class BuyerHomepageScreen extends StatefulWidget {
  const BuyerHomepageScreen({super.key});

  @override
  State<BuyerHomepageScreen> createState() => _BuyerHomepageScreenState();
}

class _BuyerHomepageScreenState extends State<BuyerHomepageScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const BuyerHomepageScreenContent(), // Главная
    const BuyerHomepageScreenPlayer(), // Вторая страница
    const BuyerHomepageScreenShop(), // Третья страница
    const BuyerHomepageScreenAccount(), // Четвёртая страница
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
