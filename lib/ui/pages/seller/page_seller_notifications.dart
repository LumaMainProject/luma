import 'package:flutter/material.dart';
import 'package:luma/ui/widgets/widget_seller_notification.dart';

class PageSellerNotifications extends StatelessWidget {
  const PageSellerNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Notifications"),
            centerTitle: true,
            floating: true,
            elevation: 0,
            scrolledUnderElevation: 0,
          ),

          SliverList.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: WidgetSellerNotification(),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: 20,
          ),
        ],
      ),
    );
  }
}


