import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/constants/app_strings.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/presentation/widgets/shop_widget.dart';
import 'package:luma_2/logic/user/user_bloc.dart';
import 'package:luma_2/logic/products/products_cubit.dart';
import 'package:luma_2/logic/stores/stores_cubit.dart';
import 'package:luma_2/data/models/user_profile.dart';

class BuyerHomepageScreenShop extends StatelessWidget {
  const BuyerHomepageScreenShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          AppStrings.buyerHomepageShop,
          style: AppTextStyles.headline,
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            final List<CurrentOrder> orders = userState.user.currentOrders;

            if (orders.isEmpty) {
              return const Center(child: Text("Нет данных о заказах"));
            }

            return BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, productsState) {
                if (productsState is ProductsLoaded) {
                  return BlocBuilder<StoresCubit, StoresState>(
                    builder: (context, storesState) {
                      if (storesState is StoresLoaded) {
                        // --- группируем заказы по storeId ---
                        final uniqueStoreIds = orders
                            .map((o) => o.storeId)
                            .toSet()
                            .toList();

                        // ---- считаем общую сумму заказа ----
                        final totalPrice = orders.fold<double>(
                          0,
                          (sum, order) => sum + order.totalPrice,
                        );

                        return Stack(
                          children: [
                            // LIST OF SHOPS
                            ListView.separated(
                              itemCount: uniqueStoreIds.length,
                              separatorBuilder: (_, __) =>
                                  AppSpacing.verticalMd,
                              padding: EdgeInsets.fromLTRB(
                                AppSpacing.paddingMd,
                                AppSpacing.paddingMd,
                                AppSpacing.paddingMd,
                                80, // 👈 отступ снизу под итог
                              ),
                              itemBuilder: (context, index) {
                                final storeId = uniqueStoreIds[index];

                                // Находим магазин
                                final store = storesState.stores.firstWhere(
                                  (s) => s.id == storeId,
                                  orElse: () => throw Exception(
                                    "Store not found for $storeId",
                                  ),
                                );

                                // Заказы по этому магазину
                                final storeOrders = orders
                                    .where((o) => o.storeId == storeId)
                                    .toList();

                                // Находим продукты для этих заказов
                                final orderedProducts = storeOrders.map((
                                  order,
                                ) {
                                  final product = productsState.products.firstWhere(
                                    (p) => p.id == order.productId,
                                    orElse: () => throw Exception(
                                      "Product not found for ${order.productId}",
                                    ),
                                  );
                                  return MapEntry(product, order);
                                }).toList();

                                return ShopWidget(
                                  store: store,
                                  productOrders: orderedProducts,
                                );
                              },
                            ),

                            // FIXED TOTAL PRICE AT BOTTOM
                            /// Панель оформления заказа
                            Positioned(
                              left: AppSpacing.paddingMd,
                              right: AppSpacing.paddingMd,
                              bottom: 100,
                              child: Container(
                                //height: AppSizes.navBarHeight,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(
                                    color: AppColors.borderColor,
                                    width: 1.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      offset: const Offset(0, -2),
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(AppSizes.buttonRadius),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(AppSizes.buttonRadius),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(
                                    AppSpacing.paddingMd,
                                  ),
                                  child: Row(
                                    mainAxisSize:
                                        MainAxisSize.max, // ✅ добавь это
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            AppStrings
                                                .buyerHomepageShopFinalPrice,
                                            style: AppTextStyles.cardMainText,
                                          ),
                                          Text(
                                            "$totalPrice ${AppStrings.currency}",
                                            style: AppTextStyles.buttonDeactive,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),

                                      SizedBox(
                                        height: AppSizes.iconXl, // фиксируем только высоту
                                        width: AppSizes.productLg,
                                        child: ElevatedButton(
                                          onPressed: () {
                                          },
                                          child: Text(
                                            AppStrings.buyerHomepageShopButton,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          } else if (userState is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("Ошибка загрузки пользователя"));
          }
        },
      ),
    );
  }
}
