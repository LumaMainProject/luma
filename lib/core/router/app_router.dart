import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_homepage_screen.dart';
import 'package:luma_2/presentation/screens/buyer_screens/buyer_pruduct_screen.dart';
import 'package:luma_2/presentation/screens/register_sceens/splash_screen.dart';
import 'package:luma_2/presentation/screens/register_sceens/welcome_screen.dart';

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

        // 🚀 1. Пока не знаем состояние — остаёмся на сплэше
        if (authState is AuthInitial) {
          return isSplash ? null : AppRoute.splash.path;
        }

        // 🚀 2. Если не залогинен → auth
        if (authState is Unauthenticated && !isAuthRoute) {
          return AppRoute.auth.path;
        }

        // 🚀 3. Если залогинен → с auth/splash перекидываем в buyerHomepage
        if ((authState is Authenticated ||
                authState is GuestAuthenticated ||
                authState is AuthenticatedProfile) &&
            (isAuthRoute || isSplash)) {
          return AppRoute.buyerHomepage.path;
        }

        return null; // ничего не делаем
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
            return BuyerPruductScreen(product: product, store: store);
          },
        ),
      ],
    );
  }
}
