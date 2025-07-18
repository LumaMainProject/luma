import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/global/params/app_images.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/global/saves/saves.dart';
import 'package:luma/ui/pages/seller/homepage/page_seller_homepage_billing.dart';
import 'package:luma/ui/pages/seller/homepage/page_seller_homepage_home.dart';
import 'package:luma/ui/pages/seller/homepage/page_seller_homepage_settings.dart';
import 'package:luma/ui/pages/seller/homepage/page_seller_homepage_store.dart';
import 'package:luma/ui/pages/seller/page_seller_notifications.dart';
import 'package:luma/ui/pages/seller/page_seller_profile.dart';

class PageSellerHomepage extends StatefulWidget {
  final int pageIndex;
  const PageSellerHomepage({super.key, this.pageIndex = 1});

  @override
  State<PageSellerHomepage> createState() => _PageSellerHomepageState();
}

class _PageSellerHomepageState extends State<PageSellerHomepage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final bool isTransparent = false;

    TabController tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.pageIndex,
    );

    final List<Widget> pages = [
      PageSellerHomepageStore(shop: SaveShop.adidas),
      PageSellerHomepageHome(),
      PageSellerHomepageBilling(),
      PageSellerHomepageSettings(),
    ];

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 64,
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: TabBar(
              controller: tabController,
              tabs: const [
                Tab(icon: Icon(AppIcons.shopCart)),
                Tab(icon: Icon(Icons.home_outlined)),
                Tab(icon: Icon(Icons.attach_money_outlined)),
                Tab(icon: Icon(Icons.settings_outlined)),
              ],
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: isTransparent,
      extendBody: isTransparent,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        //backgroundColor: Colors.transparent,
        flexibleSpace: isTransparent == true
            ? ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(color: Colors.transparent),
                ),
              )
            : null,
        title: const Text("LUMA", style: AppTextStyles.logo),
        leading: Image(
          image: AppImages.appLogo,
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
        actions: [
          // NOTIFICATIONS
          IconButton.filledTonal(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PageSellerNotifications(),
                ),
              );
            },
            icon: Icon(AppIcons.notifications),
          ),

          // PROFILE
          IconButton.filledTonal(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PageSellerProfile(),
                ),
              );
            },
            icon: Icon(AppIcons.account),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          // CustomScrollView(
          //   slivers: [
          //     SliverAppBar()
          //   ],
          // ),
          TabBarView(controller: tabController, children: pages),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
