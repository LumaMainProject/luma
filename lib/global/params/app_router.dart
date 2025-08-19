import 'package:flutter/material.dart';
import 'package:luma/ui/pages/buyer/buyer_finalize_order.dart';
import 'package:luma/ui/pages/buyer/buyer_homepage.dart';
import 'package:luma/ui/pages/buyer/buyer_item_page.dart';
import 'package:luma/ui/pages/buyer/page_buyer_notifications.dart';
import 'package:luma/ui/pages/page_register.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => PageRegister());

      case '/buyer/home':
        return MaterialPageRoute(builder: (_) => BuyerHomepage());

      case '/buyer/item_page':
        final args = settings.arguments as BuyerItemPageArgs;
        return MaterialPageRoute(
          builder: (_) => BuyerItemPage(title: args.title),
        );

      case '/buyer/notifications':
        return MaterialPageRoute(builder: (_) => PageBuyerNotifications());

      case '/buyer/finalize_order':
        return MaterialPageRoute(builder: (_) => BuyerFinalizeOrder());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Page not found"))),
        );
    }
  }

  static final Map<AppRouterEnum, String> names = {
    AppRouterEnum.routerRegisterPage: '/',
    AppRouterEnum.routerBuyerHomePage: '/buyer/home',
    AppRouterEnum.routerBuyerItemPage: '/buyer/item_page',
    AppRouterEnum.routerBuyerNotifications: '/buyer/notifications',
    AppRouterEnum.routerBuyerFinalizeOrder: '/buyer/finalize_order',
  };
}

enum AppRouterEnum {
  routerRegisterPage,
  routerBuyerHomePage,
  routerBuyerItemPage,
  routerBuyerNotifications,
  routerBuyerFinalizeOrder,
}

/// Arguments for BuyerItemPage
class BuyerItemPageArgs {
  final String title;
  BuyerItemPageArgs(this.title);
}
