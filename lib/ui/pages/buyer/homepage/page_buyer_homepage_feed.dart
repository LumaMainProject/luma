import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/global/params/app_images.dart';
import 'package:luma/ui/pages/buyer/page_buyer_item_card.dart';
import 'package:luma/ui/widgets/widget_store.dart';

class PageBuyerHomepageFeed extends StatelessWidget {
  const PageBuyerHomepageFeed({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    return CarouselView.weighted(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      controller: carouselController,
      flexWeights: [1],
      scrollDirection: Axis.vertical,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.zero),
        borderSide: BorderSide.none,
      ),
      itemSnapping: true,
      enableSplash: false,

      children: [
        WidgetFeedContainer(image: AppImages.adidasLogo),
        WidgetFeedContainer(image: AppImages.adidasLogo),
        WidgetFeedContainer(image: AppImages.adidasLogo),
        WidgetFeedContainer(image: AppImages.adidasLogo),
        WidgetFeedContainer(image: AppImages.adidasLogo),
        WidgetFeedContainer(image: AppImages.adidasLogo),
        WidgetFeedContainer(image: AppImages.adidasLogo),
        SizedBox(height: 64),
      ],
    );
  }
}

class WidgetFeedContainer extends StatelessWidget {
  final ImageProvider image;
  const WidgetFeedContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        border: BoxBorder.all(),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Stack(
        children: [
          // VIDEO
          SizedBox(
            child: Center(child: Image(image: image)),
          ),

          // ITEM
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
                  ),
                  leading: Icon(AppIcons.account),
                  title: Text("Title text"),
                  subtitle: Text("Second text"),
                  trailing: Icon(AppIcons.shopCart),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PageBuyerItemCard(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // STORE
          Align(
            alignment: Alignment.topCenter,
            child: WidgetStore(blurLevel: 5),
          ),
        ],
      ),
    );
  }
}
