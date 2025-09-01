import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/logic/products/products_cubit.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/presentation/widgets/seller/seller_product_widget.dart';

class SellerHomepageScreenProducts extends StatefulWidget {
  final Store store;

  const SellerHomepageScreenProducts({super.key, required this.store});

  @override
  State<SellerHomepageScreenProducts> createState() =>
      _SellerHomepageScreenProductsState();
}

class _SellerHomepageScreenProductsState
    extends State<SellerHomepageScreenProducts> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProductsError) {
          return Center(child: Text("Ошибка: ${state.message}"));
        }

        if (state is ProductsLoaded) {
          // Фильтруем продукты по productIds магазина
          var products = state.products
              .where((p) => widget.store.productIds.contains(p.id))
              .toList();

          // Фильтруем по поисковому запросу
          if (_searchQuery.isNotEmpty) {
            products = products
                .where(
                  (p) =>
                      p.name.toLowerCase().contains(_searchQuery.toLowerCase()),
                )
                .toList();
          }

          if (products.isEmpty) {
            return const Center(child: Text("Нет товаров в магазине"));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Поисковик
                TextField(
                  decoration: InputDecoration(
                    hintText: "Поиск по имени товара",
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                AppSpacing.verticalMd,
                // Список товаров
                Expanded(
                  child: ListView.separated(
                    itemCount: products.length,
                    separatorBuilder: (_, __) => AppSpacing.verticalMd,
                    itemBuilder: (context, index) =>
                        SellerProductWidget(product: products[index]),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
