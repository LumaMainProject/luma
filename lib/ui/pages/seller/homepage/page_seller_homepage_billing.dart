import 'dart:math';

import 'package:flutter/material.dart';
import 'package:luma/global/params/app_text_styles.dart';

class PageSellerHomepageBilling extends StatelessWidget {
  const PageSellerHomepageBilling({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Align(
              child: Text("Сумма за этот месяц", style: AppTextStyles.title),
            ),
          ),

          SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton.filled(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back_ios_rounded),
                ),
                Column(
                  children: [
                    Text("+ 7000000", style: AppTextStyles.title),
                    Text("За этот месяц", style: AppTextStyles.title2),
                  ],
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [SizedBox(height: 16), Divider(), SizedBox(height: 16)],
            ),
          ),

          SliverToBoxAdapter(
            child: Text("История выплат", style: AppTextStyles.title),
          ),

          SliverList.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("+ ${Random().nextInt(5000000) + 100000}"),
                subtitle: Text("22.07.2025 / 13.00"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.request_page_outlined),
                ),
              );
            },
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [SizedBox(height: 16), Divider(), SizedBox(height: 16)],
            ),
          ),

          SliverToBoxAdapter(
            child: Text(
              "Доступные платежные системы",
              style: AppTextStyles.title,
            ),
          ),

          SliverToBoxAdapter(child: Placeholder()),

          SliverToBoxAdapter(
            child: Column(
              children: [SizedBox(height: 16), Divider(), SizedBox(height: 16)],
            ),
          ),

          SliverToBoxAdapter(
            child: Text("Подписка", style: AppTextStyles.title),
          ),

          SliverToBoxAdapter(child: Placeholder()),
        ],
      ),
    );
  }
}
