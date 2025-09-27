import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/logic/products/products_cubit.dart';
import 'package:luma_2/logic/stores/stores_cubit.dart';
import 'package:luma_2/presentation/widgets/buyer/buyer_product_widgets/shop_image.dart';
import 'package:luma_2/presentation/widgets/buyer/item_widget.dart';

class BuyerShopScreen extends StatefulWidget {
  final Store store;
  const BuyerShopScreen({super.key, required this.store});

  @override
  State<BuyerShopScreen> createState() => _BuyerShopScreenState();
}

class _BuyerShopScreenState extends State<BuyerShopScreen> {
  int selectedTab = 0;

  Widget _buildFilterDropdown(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.secondary,
      ),
      child: DropdownButton<String>(
        value: label,
        items: [
          DropdownMenuItem(
            value: label,
            child: Text(label, style: AppTextStyles.cardMainText),
          ),
        ],
        onChanged: (_) {},
        underline: const SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.store.name),
        actions: [
          IconButton(icon: const Icon(Icons.ios_share), onPressed: () {}),
        ],
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
                if (productsState.products.isEmpty) {
                  return const Center(child: Text("Нет продуктов"));
                }

                final storesMap = {for (var s in storesState.stores) s.id: s};

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Изображение магазина
                      ShopImage(store: widget.store),

                      /// Контент с отступами
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTags(),
                            const SizedBox(height: 12),
                            _buildDescription(),
                            const SizedBox(height: 12),
                            _buildInfoButtons(),
                            const SizedBox(height: 12),
                            _buildTabSelector(),
                            const SizedBox(height: 20),

                            /// 🔹 Контент в зависимости от выбранной вкладки
                            _buildTabContent(productsState, storesMap),
                          ],
                        ),
                      ),
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

  /// --- UI helpers ---

  Widget _buildTags() {
    return Row(
      children: [
        _buildTag("Доставка сегодня", AppColors.graphUp),
        const SizedBox(width: 8),
        _buildTag("Официальный", AppColors.primary),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      widget.store.description,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildInfoButtons() {
    return Row(
      children: [
        _buildTextButton("О магазине", () {}),
        const SizedBox(width: 16),
        _buildTextButton("Политика возврата", () {}),
      ],
    );
  }

  Widget _buildTabSelector() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildTabButton(0, "Товары"),
          _buildTabButton(1, "Отзывы"),
          _buildTabButton(2, "О магазине"),
        ],
      ),
    );
  }

  Widget _buildTabContent(
    ProductsLoaded productsState,
    Map<String, Store> storesMap,
  ) {
    switch (selectedTab) {
      case 0: // Товары
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Поиск и сортировка
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Поиск...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: "По популярности",
                  items: const [
                    DropdownMenuItem(
                      value: "По популярности",
                      child: Text("По популярности"),
                    ),
                    DropdownMenuItem(value: "По цене", child: Text("По цене")),
                    DropdownMenuItem(
                      value: "По рейтингу",
                      child: Text("По рейтингу"),
                    ),
                  ],
                  onChanged: (_) {},
                  underline: const SizedBox(),
                ),
              ],
            ),

            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterDropdown("Категории"),
                  const SizedBox(width: 8),
                  _buildFilterDropdown("Цены"),
                  const SizedBox(width: 8),
                  _buildFilterDropdown("Цвета"),
                  const SizedBox(width: 8),
                  _buildFilterDropdown("Размеры"),
                  const SizedBox(width: 8),
                  _buildFilterDropdown("Время доставки"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Секции с товарами
            _buildProductsSection(
              "Популярные товары",
              productsState.products,
              storesMap,
            ),
            _buildProductsSection(
              "Больше всего продано",
              productsState.products,
              storesMap,
            ),
            _buildProductsSection(
              "Все товары магазина",
              productsState.products,
              storesMap,
            ),
          ],
        );
      case 1: // Отзывы
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Отзывы пока отсутствуют",
            style: TextStyle(fontSize: 16),
          ),
        );
      case 2: // О магазине
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            widget.store.description,
            style: const TextStyle(fontSize: 16),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildProductsSection(
    String title,
    List products,
    Map<String, Store> storesMap,
  ) {
    final filteredProducts = products
        .where((p) => p.sellerId == widget.store.id)
        .toList();

    if (filteredProducts.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.headline),
          const SizedBox(height: AppSpacing.paddingMd),
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: AppSpacing.paddingMd,
                  mainAxisSpacing: AppSpacing.paddingMd,
                  childAspectRatio: 0.65,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, i) {
                  final product = filteredProducts[i];
                  final store = storesMap[product.sellerId] ?? Store.empty();
                  return ItemWidget(product: product, store: store);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  /// --- Small widgets ---

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _buildTextButton(String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(padding: const EdgeInsets.all(12)),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String label) {
    final bool isActive = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          margin: isActive ? const EdgeInsets.all(4) : null,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.grey.shade800,
            ),
          ),
        ),
      ),
    );
  }
}
