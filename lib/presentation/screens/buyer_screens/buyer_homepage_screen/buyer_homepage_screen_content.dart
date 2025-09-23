import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/constants/app_strings.dart';
import 'package:luma_2/core/router/app_routes.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/logic/products/products_cubit.dart';
import 'package:luma_2/logic/stores/stores_cubit.dart';
import 'package:luma_2/presentation/widgets/buyer/item_widget.dart';
import 'package:luma_2/presentation/widgets/buyer/shop_button_widget.dart';

class BuyerHomepageScreenContent extends StatelessWidget {
  const BuyerHomepageScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: AppColors.primary),
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            context.pushNamed(AppRoute.buyerNotifications.name);
          },
          icon: Icon(AppIcons.notification),
        ),
        title: Text(
          AppStrings.buyerHomepageTitle,
          style: AppTextStyles.headline.copyWith(color: AppColors.primary),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(58),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.paddingMd,
              vertical: AppSpacing.paddingSm,
            ),
            child: TextField(
              readOnly: true, // ✅ чтобы клавиатура не открывалась
              onTap: () {
                context.pushNamed(
                  AppRoute.buyerSearchScreen.name,
                ); // или AppRoute.search.path
              },
              decoration: InputDecoration(
                hintText: AppStrings.buyerHomepageSearch,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, productsState) {
          return BlocBuilder<StoresCubit, StoresState>(
            builder: (context, storesState) {
              if (productsState is ProductsLoading ||
                  storesState is StoresLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (productsState is ProductsLoaded &&
                  storesState is StoresLoaded) {
                if (productsState.products.isEmpty) {
                  return const Center(child: Text("Нет продуктов"));
                }

                final storesMap = {for (var s in storesState.stores) s.id: s};

                // --- Фильтруем скидки ---
                final discountProducts =
                    productsState.products
                        .where((p) => (p.discountPrice ?? 0) > 0)
                        .toList()
                      ..sort(
                        (a, b) => (b.discountPrice ?? 0).compareTo(
                          a.discountPrice ?? 0,
                        ),
                      );

                // --- Фильтруем хиты сезона 2025 ---
                final hitProducts = List.from(productsState.products)
                  ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

                return SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: AppSpacing.bottomNavBar),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMd,
                        ),
                        child: Text("Магазины", style: AppTextStyles.headline),
                      ),
                      const SizedBox(height: AppSpacing.paddingSm),
                      SizedBox(
                        height: 90,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.paddingMd,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: storesState.stores.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: AppSpacing.paddingSm),
                          itemBuilder: (context, index) {
                            final s = storesState.stores[index];
                            return ShopButtonWidget(store: s);
                          },
                        ),
                      ),

                      // Скидки
                      const SizedBox(height: AppSpacing.paddingMd),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMd,
                        ),
                        child: Text("Скидки", style: AppTextStyles.headline),
                      ),
                      const SizedBox(height: AppSpacing.paddingMd),
                      SizedBox(
                        height: AppSizes.cartSm,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.paddingMd,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: discountProducts.length,
                          itemBuilder: (context, i) {
                            final product = discountProducts[i];
                            final store =
                                storesMap[product.sellerId] ?? Store.empty();
                            return ItemWidget(
                              product: product,
                              store: store,
                              width: AppSizes.productSm,
                            );
                          },
                          separatorBuilder: (_, __) => AppSpacing.horizontalSm,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.paddingLg),

                      // Хит сезона 2025
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMd,
                        ),
                        child: Text(
                          "Хит сезона 2025",
                          style: AppTextStyles.headline,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.paddingMd),
                      SizedBox(
                        height: AppSizes.cartMd,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.paddingMd,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: hitProducts.length,
                          itemBuilder: (context, i) {
                            final product = hitProducts[i];
                            final store =
                                storesMap[product.sellerId] ?? Store.empty();
                            return ItemWidget(
                              product: product,
                              store: store,
                              width: AppSizes.productMd,
                              customText: "Hit '25",
                            );
                          },
                          separatorBuilder: (_, __) => AppSpacing.horizontalSm,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.paddingLg),

                      // Grid view всех товаров
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMd,
                        ),
                        child: Text(
                          "Популярное",
                          style: AppTextStyles.headline,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.paddingMd),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMd,
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount = 2; // по умолчанию телефон
                            if (constraints.maxWidth >= 900) {
                              crossAxisCount = 5; // ПК
                            } else if (constraints.maxWidth >= 600) {
                              crossAxisCount = 3; // планшет
                            }

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: AppSpacing.paddingMd,
                                    mainAxisSpacing: AppSpacing.paddingMd,
                                    childAspectRatio: 0.65,
                                  ),
                              itemCount: productsState.products.length,
                              itemBuilder: (context, i) {
                                final product = productsState.products[i];
                                final store =
                                    storesMap[product.sellerId] ??
                                    Store.empty();
                                return ItemWidget(
                                  product: product,
                                  store: store,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else if (productsState is ProductsError) {
                return Center(
                  child: Text("Ошибка продуктов: ${productsState.message}"),
                );
              } else if (storesState is StoresError) {
                return Center(
                  child: Text("Ошибка магазинов: ${storesState.message}"),
                );
              }

              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}
