import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:luma_2/core/constants/app_images.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:shimmer/shimmer.dart';

class ShopImage extends StatefulWidget {
  final Store store;

  const ShopImage({super.key, required this.store});

  @override
  State<ShopImage> createState() => _ShopImageState();
}

class _ShopImageState extends State<ShopImage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity, // растягиваем по ширине
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        color: AppColors.alterGray,
      ),
      child: ClipRRect(
        child: Stack(
          fit: StackFit.expand, // важно! растягивает детей на весь Stack
          children: [
            CachedNetworkImage(
              imageUrl: widget.store.bannerUrl ?? AppImages.logo,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(color: Colors.white),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),

            // Кнопка избранного
            Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  iconSize: 20,
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? AppColors.primary : AppColors.textDark,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ),
            ),

            // Нижний блок с названием и статистикой
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.store.name,
                      style: AppTextStyles.headline.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppSizes.avatarMd,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: widget.store.logoUrl ?? '',
                            width: AppSizes.avatarMd,
                            height: AppSizes.avatarMd,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: AppSizes.avatarMd,
                                height: AppSizes.avatarMd,
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.store),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${widget.store.rating} (${widget.store.reviewsCount})",
                          style: AppTextStyles.cardMainText.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Заказов: ${widget.store.totalOrders}",
                          style: AppTextStyles.cardMainText.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Подписчиков: ${widget.store.favoritesCount}",
                          style: AppTextStyles.cardMainText.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
