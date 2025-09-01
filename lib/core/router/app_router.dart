import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/data/models/user_role.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_account_screens/buyer_account_edit.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_account_screens/buyer_account_favorite.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_account_screens/buyer_account_messenger.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_account_screens/buyer_account_orders.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_homepage_screen.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_notifications.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_pruduct_screen.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_purchase_screen.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_search_screen.dart';
import 'package:luma_2/presentation/screens/register_sceens/registration_screen.dart';
import 'package:luma_2/presentation/screens/register_sceens/splash_screen.dart';
import 'package:luma_2/presentation/screens/register_sceens/welcome_screen.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_homepage_screen.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_notifications_screen.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_product_edit_screen.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_promo_screen.dart';

import 'app_routes.dart';
import '../../logic/auth/auth_cubit.dart';
import 'go_router_refresh_stream.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static GoRouter build(AuthCubit authCubit) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: AppRoute.splash.path, // ✅ теперь splash
      refreshListenable: GoRouterRefreshStream(authCubit.stream),

      redirect: (context, state) {
        final authState = authCubit.state;

        final isSplash = state.fullPath == AppRoute.splash.path;
        final isAuthRoute = state.fullPath == AppRoute.auth.path;

        if (authState is AuthInitial) {
          return isSplash ? null : AppRoute.splash.path;
        }

        if (authState is Unauthenticated &&
            !(isAuthRoute || state.fullPath == AppRoute.registrer.path)) {
          return AppRoute.auth.path;
        }

        if ((authState is Authenticated ||
                authState is GuestAuthenticated ||
                authState is AuthenticatedProfile) &&
            (isAuthRoute || isSplash)) {
          // ✅ редирект по роли
          if (authCubit.role == UserRole.seller) {
            return AppRoute.sellerHomepageScreen.path;
          } else {
            return AppRoute.buyerHomepage.path;
          }
        }

        return null;
      },

      routes: [
        GoRoute(
          path: AppRoute.splash.path,
          name: AppRoute.splash.name,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoute.auth.path,
          name: AppRoute.auth.name,
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: AppRoute.registrer.path,
          name: AppRoute.registrer.name,
          builder: (context, state) => const RegistrationScreen(),
        ),
        GoRoute(
          path: AppRoute.buyerHomepage.path,
          name: AppRoute.buyerHomepage.name,
          builder: (context, state) => const BuyerHomepageScreen(),
        ),
        GoRoute(
          path: AppRoute.buyerProduct.path,
          name: AppRoute.buyerProduct.name,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            if (extra == null) throw Exception('Product and Store not passed!');

            final Product product = extra['product'] as Product;
            final Store store = extra['store'] as Store;
            return BuyerProductScreen(product: product, store: store);
          },
        ),
        GoRoute(
          path: AppRoute.buyerPurchase.path,
          name: AppRoute.buyerPurchase.name,
          builder: (context, state) => const BuyerPurchaseScreen(),
        ),
        GoRoute(
          path: AppRoute.buyerNotifications.path,
          name: AppRoute.buyerNotifications.name,
          builder: (context, state) => const BuyerNotifications(),
        ),
        GoRoute(
          path: AppRoute.buyerSearchScreen.path,
          name: AppRoute.buyerSearchScreen.name,
          builder: (context, state) => const BuyerSearchScreen(),
        ),

        // ACCOUNT
        GoRoute(
          path: AppRoute.buyerAccountEdit.path,
          name: AppRoute.buyerAccountEdit.name,
          builder: (context, state) => const BuyerAccountEdit(),
        ),
        GoRoute(
          path: AppRoute.buyerAccountFavorite.path,
          name: AppRoute.buyerAccountFavorite.name,
          builder: (context, state) => const BuyerAccountFavorite(),
        ),
        GoRoute(
          path: AppRoute.buyerAccountMessenger.path,
          name: AppRoute.buyerAccountMessenger.name,
          builder: (context, state) => const BuyerAccountMessenger(),
        ),
        GoRoute(
          path: AppRoute.buyerAccountOrders.path,
          name: AppRoute.buyerAccountOrders.name,
          builder: (context, state) => const BuyerAccountOrders(),
        ),

        // SELLER
        GoRoute(
          path: AppRoute.sellerHomepageScreen.path,
          name: AppRoute.sellerHomepageScreen.name,
          builder: (context, state) => const SellerHomepageScreen(),
        ),
        GoRoute(
          path: AppRoute.sellerNoticifactions.path,
          name: AppRoute.sellerNoticifactions.name,
          builder: (context, state) => const SellerNotificationsScreen(),
        ),
        GoRoute(
          path: AppRoute.sellerProductEdit.path,
          name: AppRoute.sellerProductEdit.name,
          builder: (context, state) => const SellerProductEditScreen(),
        ),
        GoRoute(
          path: AppRoute.sellerPromo.path,
          name: AppRoute.sellerPromo.name,
          builder: (context, state) => const SellerPromoScreen(),
        ),
      ],
    );
  }
}
