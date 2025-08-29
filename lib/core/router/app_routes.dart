enum AppRoute { splash, auth, buyerHomepage, buyerProduct }

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
    }
  }

  String get name => toString().split('.').last;
}
