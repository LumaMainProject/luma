import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/logic/products/products_cubit.dart';
import 'package:luma_2/logic/stores/stores_cubit.dart';
import 'package:luma_2/presentation/widgets/item_widget.dart';
import 'package:luma_2/presentation/widgets/photo_search_overlay.dart';
import 'package:luma_2/presentation/widgets/shop_button_widget.dart';

class BuyerSearchScreen extends StatefulWidget {
  const BuyerSearchScreen({super.key});

  @override
  State<BuyerSearchScreen> createState() => _BuyerSearchScreenState();
}

class _BuyerSearchScreenState extends State<BuyerSearchScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  String query = "";

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      query = value.toLowerCase();
    });
  }

  void _showCameraDialog() {
    showDialog(
      context: context,
      barrierColor: Colors
          .transparent, // чтобы фон был полупрозрачным через BackdropFilter
      builder: (_) => PhotoSearchOverlay(onClose: () => Navigator.pop(context)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Поиск"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(58),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.paddingMd,
              vertical: AppSpacing.paddingSm,
            ),
            child: TextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: "Найти товар, бренд, магазин",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: _showCameraDialog,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
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
              }

              if (productsState is ProductsLoaded &&
                  storesState is StoresLoaded) {
                final storesMap = {for (var s in storesState.stores) s.id: s};

                final filteredProducts = productsState.products
                    .where((p) => p.name.toLowerCase().contains(query))
                    .toList();

                final filteredStores = storesState.stores
                    .where((s) => s.name.toLowerCase().contains(query))
                    .toList();

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.paddingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Магазины
                      if (filteredStores.isNotEmpty) ...[
                        Text("Магазины", style: AppTextStyles.headline),
                        const SizedBox(height: AppSpacing.paddingSm),
                        SizedBox(
                          height: 90,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: filteredStores.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: AppSpacing.paddingSm),
                            itemBuilder: (context, index) {
                              final s = filteredStores[index];
                              return ShopButtonWidget(store: s);
                            },
                          ),
                        ),
                        const SizedBox(height: AppSpacing.paddingLg),
                      ],

                      // Продукты
                      if (filteredProducts.isNotEmpty) ...[
                        Text("Товары", style: AppTextStyles.headline),
                        const SizedBox(height: AppSpacing.paddingSm),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount = 2;
                            if (constraints.maxWidth >= 900) {
                              crossAxisCount = 5;
                            } else if (constraints.maxWidth >= 600) {
                              crossAxisCount = 3;
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
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, i) {
                                final product = filteredProducts[i];
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
                      ],

                      if (filteredStores.isEmpty && filteredProducts.isEmpty)
                        const Center(child: Text("Ничего не найдено")),
                    ],
                  ),
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
