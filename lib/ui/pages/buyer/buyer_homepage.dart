import 'package:flutter/material.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/ui/pages/buyer/homepage/page_buyer_cart.dart';
import 'package:luma/ui/pages/buyer/homepage/page_buyer_homepage.dart';
import 'package:luma/ui/pages/buyer/homepage/page_buyer_player.dart';
import 'package:luma/ui/pages/buyer/homepage/page_buyer_profile.dart';
import 'package:luma/ui/widgets/custom_bottom_nav_bar.dart';

class BuyerHomepage extends StatefulWidget {
  const BuyerHomepage({super.key});

  @override
  State<BuyerHomepage> createState() => _BuyerHomepageState();
}

class _BuyerHomepageState extends State<BuyerHomepage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    PageBuyerHomepage(),
    PageBuyerPlayer(),
    PageBuyerCart(),
    PageBuyerProfile(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: Stack(
        children: [
          pages[selectedIndex],

          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBar(
              currentIndex: selectedIndex,
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
