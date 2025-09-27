import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/constants/app_images.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/logic/products/products_cubit.dart';
import 'package:luma_2/logic/stores/stores_cubit.dart';
import 'package:luma_2/presentation/widgets/buyer/item_widget.dart';
import 'package:luma_2/presentation/widgets/buyer/photo_search_overlay.dart';
import 'package:luma_2/presentation/widgets/buyer/shop_button_widget.dart';

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

  final List<String> _brands = [
    "ZARA",
    "H&M",
    "UNIQLO",
    "NIKE",
    "ADIDAS",
    "MANGO",
    "BERSHKA",
  ];

  final List<Map<String, String>> _categories = [
    {"title": "Женская", "image": AppImages.searchWomen},
    {"title": "Мужская", "image": AppImages.searchMen},
    {"title": "Обувь", "image": AppImages.searchShoes},
    {"title": "Платья", "image": AppImages.searchBackground},
    {"title": "Футболки", "image": AppImages.searchTshirts},
    {"title": "Джинсы", "image": AppImages.searchJeans},
    {"title": "Юбки", "image": AppImages.searchBackground},
    {"title": "Блузы", "image": AppImages.searchBlouses},
    {"title": "Худи", "image": AppImages.searchHoodies},
    {"title": "Костюмы", "image": AppImages.searchSuits},
    {"title": "Верхняя одежда", "image": AppImages.searchOuterwear},
    {"title": "Куртки", "image": AppImages.searchBackground},
    {"title": "Спортивная", "image": AppImages.searchSport},
    {"title": "Бельё", "image": AppImages.searchUnderwear},
    {"title": "Сумки", "image": AppImages.searchBags},
    {"title": "Украшения", "image": AppImages.searchJewelry},
    {"title": "Очки", "image": AppImages.searchGlasses},
    {"title": "Часы", "image": AppImages.searchWatches},
    {"title": "Детская", "image": AppImages.searchKids},
    {"title": "Косметика", "image": AppImages.searchCosmetics},
    {"title": "Парфюм", "image": AppImages.searchPerfume},
    {"title": "Домашняя", "image": AppImages.searchHome},
  ];

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
                      if (filteredStores.isNotEmpty &&
                          _controller.text.isNotEmpty) ...[
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
                      if (filteredProducts.isNotEmpty &&
                          _controller.text.isNotEmpty) ...[
                        Text("Категории", style: AppTextStyles.headline),
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

                      // Магазины
                      if (_controller.text.isEmpty) ...[
                        // Быстрый доступ
                        Text("Быстрый доступ", style: AppTextStyles.headline),
                        const SizedBox(height: AppSpacing.paddingSm),
                        Wrap(
                          spacing: AppSpacing.paddingSm,
                          runSpacing: AppSpacing.paddingSm,
                          children: [
                            _QuickAccessButton("Популярное"),
                            _QuickAccessButton("Новинки"),
                            _QuickAccessButton("Скидки"),
                            _QuickAccessButton("Быстрая доставка"),
                            _QuickAccessButton("До 200 000"),
                            _QuickAccessButton("Эко"),
                            _QuickAccessButton("Made in UZ"),
                            _QuickAccessButton("Сегодня"),
                            _QuickAccessButton("Бренды"),
                            _QuickAccessButton("Коллаборации"),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.paddingLg),

                        // Магазины
                        // Популярные бренды
                        Text(
                          "Популярные бренды",
                          style: AppTextStyles.headline,
                        ),
                        const SizedBox(height: AppSpacing.paddingSm),

                        SizedBox(
                          height: 100, // под карточки с названиями
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _brands.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: AppSpacing.paddingSm),
                            itemBuilder: (context, index) {
                              final brand = _brands[index];
                              return _BrandCard(name: brand);
                            },
                          ),
                        ),
                      ],

                      // Продукты
                      if (_controller.text.isEmpty) ...[
                        Text("Категории", style: AppTextStyles.headline),
                        const SizedBox(height: AppSpacing.paddingSm),

                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // две колонки
                                crossAxisSpacing: AppSpacing.paddingMd,
                                mainAxisSpacing: AppSpacing.paddingMd,
                                childAspectRatio:
                                    267 / 105, // соотношение сторон
                              ),
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            final cat = _categories[index];
                            return _CategoryCard(
                              title: cat['title']!,
                              image: cat['image']!,
                            );
                          },
                        ),
                      ],
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

class _QuickAccessButton extends StatelessWidget {
  final String text;
  const _QuickAccessButton(this.text);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // тут можно добавить логику фильтрации или навигации
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(text, style: AppTextStyles.cardMainText),
      ),
    );
  }
}

class _BrandCard extends StatelessWidget {
  final String name;
  const _BrandCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 67,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 74,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary,
                ),
                alignment: Alignment.center,
                child: Text(
                  name.characters.first, // первая буква
                  style: AppTextStyles.headline2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: AppTextStyles.textButton,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String image;

  const _CategoryCard({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand, // заставляем детей занимать весь контейнер
        children: [
          Image.network(image, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withAlpha(100), Colors.transparent],
              ),
            ),
          ),
          Positioned(
            left: 8,
            bottom: 8,
            child: Text(
              title,
              style: AppTextStyles.cardTag.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
