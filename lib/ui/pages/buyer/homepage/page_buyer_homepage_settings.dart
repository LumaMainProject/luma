import 'package:flutter/material.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/pages/seller/page_seller_homepage.dart';

class PageBuyerHomepageSettings extends StatelessWidget {
  const PageBuyerHomepageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PageSellerHomepage(pageIndex: 1),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: Size(0, 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
                ),
              ),
              child: Text("Switch to Seller", style: AppTextStyles.title),
            ),
          ),
        ),
      ],
    );
  }
}
