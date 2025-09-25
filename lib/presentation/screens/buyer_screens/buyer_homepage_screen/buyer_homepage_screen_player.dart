import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luma_2/core/constants/app_videos.dart';
import 'package:luma_2/core/router/app_routes.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/logic/products/products_cubit.dart';
import 'package:luma_2/logic/stores/stores_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class BuyerHomepageScreenPlayer extends StatefulWidget {
  const BuyerHomepageScreenPlayer({super.key});

  @override
  State<BuyerHomepageScreenPlayer> createState() =>
      _BuyerHomepageScreenPlayerState();
}

class _BuyerHomepageScreenPlayerState extends State<BuyerHomepageScreenPlayer> {
  final List<String> videoAssets = [
    AppVideos.first,
    AppVideos.second,
    AppVideos.third,
    AppVideos.four,
    AppVideos.fifth,
  ];

  final List<Store> storeAssets = [];

  final List<Product> productsAssets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StoresCubit, StoresState>(
        builder: (context, storesState) {
          return BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, productsState) {
              if (productsState is ProductsLoading ||
                  storesState is StoresLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (productsState is ProductsLoaded &&
                  storesState is StoresLoaded) {
                if (productsState.products.isEmpty) {
                  return const Center(child: Text("Нет видео"));
                }

                for (int i = 0; i < videoAssets.length; i++) {
                  storeAssets.add(storesState.stores[i % 2 == 0 ? 0 : 1]);
                }

                for (int i = 0; i < videoAssets.length; i++) {
                  productsAssets.add(productsState.products[i]);
                }

                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: videoAssets.length,
                  itemBuilder: (context, index) {
                    return VideoPlayerItem(
                      assetPath: videoAssets[index],
                      overlayUI: _buildOverlayUI(index),
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  Widget _buildOverlayUI(int index) {
    const categories = [
      "Все",
      "Мода",
      "Красота",
      "Аксессуары",
      "Дом",
      "Техника",
    ];

    return SafeArea(
      child: Stack(
        children: [
          // Верхний бар с названием
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 92,
                  height: 42,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(125),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Center(
                    child: Text(
                      "LUMA",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Горизонтальная прокручиваемая строка категорий
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: categories.map((cat) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(125),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          cat,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Правая колонка кнопок и блока с названием/описанием/карточкой
          Positioned(
            right: 16,
            bottom: 100,
            left: 16, // даём левый отступ, чтобы блок растягивался
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Левый блок — растягивается на доступное место
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          VideoLocalLogo(store: storeAssets[index]),
                          const SizedBox(width: 4),
                          Text(
                            productsAssets[index].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        productsAssets[index].description,
                        maxLines: 3,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Логотип продукта слева
                              VideoProductLogo(product: productsAssets[index]),

                              const SizedBox(width: 8),

                              // Колонка с информацией о продукте
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // 1-я строка: иконка звезды, текст, точка, текст, текст
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.orange,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          "${productsAssets[index].rating}", // пример рейтинга
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(width: 4),
                                        const Text(
                                          "•",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Заказов:", // пример текста
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${productsAssets[index].favoritesCount}",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 4),

                                    // 2-я строка: описание в 1 строчку с троеточием
                                    Text(
                                      productsAssets[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    ),

                                    const SizedBox(height: 4),

                                    // 3-я строка: перечеркнутая цена
                                    productsAssets[index].discountPrice !=
                                                null &&
                                            productsAssets[index]
                                                    .discountPrice !=
                                                0
                                        ? Text(
                                            "${productsAssets[index].discountPrice} сум",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          )
                                        : const SizedBox(),

                                    const SizedBox(height: 4),

                                    // 4-я строка: цена и кнопка Подробнее
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${productsAssets[index].price} сум",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            GoRouter.of(context).push(
                                              AppRoute.buyerProduct.path,
                                              extra: {
                                                'product': productsAssets[index],
                                                'store': storeAssets[index],
                                              },
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.secondary,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                              horizontal: 8,
                                            ),
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          child: const Text(
                                            "Подробнее",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16), // Отступ между блоками
                // Правая колонка — кнопки
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildButtonWithLabel(
                      icon: Icons.favorite_outline,
                      label: "Избранное",
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                    _buildButtonWithLabel(
                      icon: Icons.share_outlined,
                      label: "Поделиться",
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                    _buildButtonWithLabel(
                      icon: Icons.shopping_cart_outlined,
                      label: "В корзину",
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonWithLabel({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: Colors.black, size: 20),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String assetPath;
  final Widget? overlayUI; // сюда можно добавлять кастомный UI

  const VideoPlayerItem({super.key, required this.assetPath, this.overlayUI});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (!_controller.value.isInitialized) return;
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.assetPath),
      onVisibilityChanged: (info) {
        if (!_controller.value.isInitialized || !mounted) return;
        if (info.visibleFraction == 0) {
          _controller.pause();
        } else {
          _controller.play();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Видео
          if (_controller.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),

          // Полноэкранный GestureDetector поверх видео для Play/Pause
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _togglePlayPause,
              child: const SizedBox.shrink(),
            ),
          ),

          // Play/Pause иконка по центру
          if (!_controller.value.isPlaying)
            const Icon(Icons.play_arrow, size: 80, color: Colors.white70),

          // Кастомный UI поверх видео
          if (widget.overlayUI != null) widget.overlayUI!,
        ],
      ),
    );
  }
}

class VideoLocalLogo extends StatelessWidget {
  final Store store;
  const VideoLocalLogo({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return store.logoUrl != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: store.logoUrl!,
              width: 20,
              height: 20,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(width: 20, height: 20, color: Colors.white),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          )
        : const SizedBox();
  }
}

class VideoProductLogo extends StatelessWidget {
  final Product product;
  const VideoProductLogo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: CachedNetworkImage(
        imageUrl: product.imageUrl,
        width: 61,
        height: 85,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(width: 61, height: 85, color: Colors.white),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
