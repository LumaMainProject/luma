enum AppRoute {
  splash,
  auth,
  registrer,
  buyerHomepage,
  buyerProduct,
  buyerPurchase,
  buyerNotifications,
  buyerAccountEdit,
  buyerAccountFavorite,
  buyerAccountMessenger,
  buyerAccountOrders,
  buyerSearchScreen,
  buyerShopScreen,
  sellerHomepageScreen,
  sellerNoticifactions,
  sellerProductEdit,
  sellerPromo,
  sellerAddPage,
}

extension AppRoutePath on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.splash:
        return '/';
      case AppRoute.auth:
        return '/auth';
      case AppRoute.registrer:
        return '/register';
      case AppRoute.buyerHomepage:
        return '/buyer/home';
      case AppRoute.buyerProduct:
        return '/buyer/product';
      case AppRoute.buyerPurchase:
        return '/buyer/purchase';
      case AppRoute.buyerNotifications:
        return '/buyer/buyerNotifications';
      case AppRoute.buyerSearchScreen:
        return '/buyer/buyerSearchScreen';
      case AppRoute.buyerShopScreen:
        return '/buyer/buyerShopScreen';

      case AppRoute.buyerAccountEdit:
        return '/buyer/buyerAccountEdit';
      case AppRoute.buyerAccountFavorite:
        return '/buyer/buyerAccountFavorite';
      case AppRoute.buyerAccountMessenger:
        return '/buyer/buyerAccountMessenger';
      case AppRoute.buyerAccountOrders:
        return '/buyer/buyerAccountOrders';

      case AppRoute.sellerHomepageScreen:
        return '/buyer/sellerHomepageScreen';
      case AppRoute.sellerNoticifactions:
        return '/buyer/sellerNoticifactions';
      case AppRoute.sellerProductEdit:
        return '/buyer/sellerProductEdit';
      case AppRoute.sellerPromo:
        return '/buyer/sellerPromo';
      case AppRoute.sellerAddPage:
        return '/buyer/sellerAddPage';
    }
  }

  String get name => toString().split('.').last;
}
