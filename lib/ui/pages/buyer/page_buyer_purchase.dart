import 'package:flutter/material.dart';
import 'package:luma/global/app_icons.dart';
import 'package:luma/global/app_text_styles.dart';

class PageBuyerPurchase extends StatelessWidget {
  const PageBuyerPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Checkout"),
          ),

          SliverList.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  leading: Icon(AppIcons.appLogo),
                  title: Text("Text"),
                  trailing: Text("Price"),
                ),
              );
            },
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("Total", style: AppTextStyles.title)],
              ),
            ),
          ),

          SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Placeholder(),
          )),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Divider(),
                  Text("Delivery Fee", style: AppTextStyles.title),
                  Divider(),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text("PayMe", style: AppTextStyles.title2),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("Click", style: AppTextStyles.title2),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("Uzum", style: AppTextStyles.title2),
                      ),
                    ],
                  ),
              
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
