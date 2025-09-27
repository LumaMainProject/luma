import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/logic/seller_add_product/seller_add_product_bloc.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_add_screen_tabs/main_tab.dart';
import 'package:luma_2/presentation/screens/seller_screens/seller_add_screen_tabs/media_tab.dart';

enum ProductTab {
  media,
  main,
  categories,
  variations,
  prices,
  stock,
  related,
  feed,
  seo,
}

class SellerAddProductScreen extends StatefulWidget {
  final Store store;
  final Product? product;

  const SellerAddProductScreen({super.key, required this.store, this.product});

  @override
  State<SellerAddProductScreen> createState() => _SellerAddProductScreenState();
}

class _SellerAddProductScreenState extends State<SellerAddProductScreen> {
  ProductTab currentTab = ProductTab.media;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerAddProductBloc, SellerAddProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.isEdit ? "Редактировать товар" : "Добавить товар",
            ),
          ),

          // --- Контент ---
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- Grid вкладок ---
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildTabButton(ProductTab.media, "Медиа", Icons.photo),
                    _buildTabButton(
                      ProductTab.main,
                      "Основное",
                      Icons.list_alt,
                    ),
                    _buildTabButton(
                      ProductTab.categories,
                      "Категории",
                      Icons.category,
                    ),
                    _buildTabButton(
                      ProductTab.variations,
                      "Вариации",
                      Icons.dashboard_customize,
                    ),
                    _buildTabButton(
                      ProductTab.prices,
                      "Цены",
                      Icons.attach_money,
                    ),
                    _buildTabButton(ProductTab.stock, "Склад", Icons.inventory),
                    _buildTabButton(
                      ProductTab.related,
                      "Связанное",
                      Icons.link,
                    ),
                    _buildTabButton(
                      ProductTab.feed,
                      "Лента",
                      Icons.dynamic_feed,
                    ),
                    _buildTabButton(ProductTab.seo, "SEO", Icons.search),
                  ],
                ),

                const SizedBox(height: 14),

                // --- Контент вкладки ---
                IndexedStack(
                  index: currentTab.index,
                  children: const [
                    MainTab(), // ProductTab.main (1)
                    MediaTab(), // ProductTab.media (0)
                    _EmptyTab("Категории"), // ProductTab.categories (2)
                    _EmptyTab("Вариации"), // ProductTab.variations (3)
                    _EmptyTab("Цены"), // ProductTab.prices (4)
                    _EmptyTab("Склад"), // ProductTab.stock (5)
                    _EmptyTab("Связанное"), // ProductTab.related (6)
                    _EmptyTab("Лента"), // ProductTab.feed (7)
                    _EmptyTab("SEO"), // ProductTab.seo (8)
                  ],
                ),
              ],
            ),
          ),

          // --- Нижняя панель с кнопками ---
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: null, // неактивная
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.grey.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Сохранить черновик",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Опубликовать",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabButton(
    ProductTab tab,
    String title,
    IconData icon, {
    bool completed = false,
  }) {
    final isActive = currentTab == tab;

    return GestureDetector(
      onTap: () => setState(() => currentTab = tab),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        width: 117,
        height: 60,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.borderColor,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.white : Colors.brown,
                  size: 18,
                ),
                if (completed)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? Colors.white : Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- Вкладки -------------------

class _EmptyTab extends StatelessWidget {
  final String title;
  const _EmptyTab(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "$title (пусто)",
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
