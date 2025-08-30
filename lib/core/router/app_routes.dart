enum AppRoute {
  splash,
  auth,
  buyerHomepage,
  buyerProduct,
  buyerPurchase,
  buyerNotifications,
  buyerAccountEdit,
  buyerAccountFavorite,
  buyerAccountMessenger,
  buyerAccountOrders,
}

extension AppRoutePath on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.splash:
        return '/';
      case AppRoute.auth:
        return '/auth';
      case AppRoute.buyerHomepage:
        return '/buyer/home';
      case AppRoute.buyerProduct:
        return '/buyer/product';
      case AppRoute.buyerPurchase:
        return '/buyer/purchase';
      case AppRoute.buyerNotifications:
        return '/buyer/buyerNotifications';

      case AppRoute.buyerAccountEdit:
        return '/buyer/buyerAccountEdit';
      case AppRoute.buyerAccountFavorite:
        return '/buyer/buyerAccountFavorite';
      case AppRoute.buyerAccountMessenger:
        return '/buyer/buyerAccountMessenger';
      case AppRoute.buyerAccountOrders:
        return '/buyer/buyerAccountOrders';
    }
  }

  String get name => toString().split('.').last;
}
