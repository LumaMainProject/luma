import 'package:flutter/material.dart';
import 'package:luma/global/app_text_styles.dart';
import 'package:luma/ui/widgets/widget_seller_item_card_statistic.dart';

class PageSellerHomepageHome extends StatelessWidget {
  const PageSellerHomepageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text("Top Sellers", style: AppTextStyles.title),
          ),
        ),

        SliverList.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: WidgetSellerItemCardStatistic(),
            );
          },
          itemCount: 3,
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                minimumSize: Size(0, 80),
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.all(Radius.circular(16)))
              ),
              child: Text("BOOST", style: AppTextStyles.title),
            ),
          ),
        ),

                const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text("Statistic", style: AppTextStyles.title),
          ),
        ),

        SliverList.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: WidgetSellerItemCardStatistic(),
            );
          },
          itemCount: 10,
        ),
      ],
    );
  }
}

