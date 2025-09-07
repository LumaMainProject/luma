import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/router/app_routes.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/logic/analytics/analytics_bloc.dart';
import 'package:luma_2/logic/auth/auth_cubit.dart';
import 'package:luma_2/logic/seller_stores/seller_stores_bloc.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_homepage_screen/seller_homepage_screen_account.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_homepage_screen/seller_homepage_screen_analitics.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_homepage_screen/seller_homepage_screen_content.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_homepage_screen/seller_homepage_screen_orders.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_homepage_screen/seller_homepage_screen_products.dart';
import 'package:luma_2/presentation/widgets/buyer/custom_nav_bar.dart';

class SellerHomepageScreen extends StatefulWidget {
  const SellerHomepageScreen({super.key});

  @override
  State<SellerHomepageScreen> createState() => _SellerHomepageScreenState();
}

class _SellerHomepageScreenState extends State<SellerHomepageScreen> {
  int selectedIndex = 0;
  int currentStore = 0;

  void _navigateToLogin(BuildContext context) {
    context.go(AppRoute.auth.path);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerStoresBloc, SellerStoresState>(
      builder: (context, state) {
        if (state is! SellerStoresLoaded) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final store = state.stores[currentStore];

        context.read<AnalyticsBloc>().add(LoadStoreAnalytics(store.id));

        final pages = [
          SellerHomepageScreenContent(store: store),
          SellerHomepageScreenProducts(store: store),
          SellerHomepageScreenOrders(store: store),
          const SellerHomepageScreenAnalitics(),
          const SellerHomepageScreenAccount(),
        ];

        return Scaffold(
          appBar: AppBar(
            title: Text(store.name),
            actions: [
              IconButton(
                onPressed: () {
                  _navigateToLogin(context);
                  context.read<AuthCubit>().signOut();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(AppSpacing.paddingMd),
                    child: Text("Ваши магазины", style: AppTextStyles.headline),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(AppSpacing.paddingMd),
                      itemCount: state.stores.length,
                      separatorBuilder: (_, __) => AppSpacing.verticalMd,
                      itemBuilder: (context, index) {
                        final s = state.stores[index];
                        return OutlinedButton(
                          onPressed: () {
                            setState(() {
                              currentStore = index;
                              context.read<AnalyticsBloc>().add(
                                LoadStoreAnalytics(s.id),
                              );
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: currentStore == index
                                ? AppColors.primary.withAlpha(25)
                                : AppColors.white,
                          ),
                          child: Text(s.name),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Stack(
            children: [
              pages[selectedIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomNavBar(
                  icons: [
                    AppIcons.sellerHomepage,
                    AppIcons.sellerProducts,
                    AppIcons.sellerOrders,
                    AppIcons.sellerAnalitics,
                    AppIcons.sellerAccount,
                  ],
                  selectedIndex: selectedIndex,
                  onTap: (index) => setState(() => selectedIndex = index),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
