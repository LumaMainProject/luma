import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/logic/products/products_cubit.dart';
import 'package:luma_2/logic/stores/stores_cubit.dart';
import 'package:luma_2/logic/user/user_bloc.dart';
import 'package:luma_2/presentation/widgets/item_widget.dart';

class BuyerAccountFavorite extends StatelessWidget {
  const BuyerAccountFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Избранное")),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is! UserLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          return BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, productsState) {
              if (productsState is! ProductsLoaded) {
                return const Center(child: CircularProgressIndicator());
              }

              return BlocBuilder<StoresCubit, StoresState>(
                builder: (context, storesState) {
                  if (storesState is! StoresLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final storesMap = {for (var s in storesState.stores) s.id: s};

                  if (userState.user.favoriteProducts.isEmpty) {
                    return const Center(
                      child: Text(
                        "Похоже у вас пока нет избранного",
                        style: AppTextStyles.headline,
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(AppSpacing.paddingMd),
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
                          itemCount: userState.user.favoriteProducts.length,
                          itemBuilder: (context, i) {
                            final product = productsState.products[i];
                            final store =
                                storesMap[product.sellerId] ?? Store.empty();
                            return ItemWidget(product: product, store: store);
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
