import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:luma_2/core/constants/app_icons.dart';
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        color: AppColors.alterGray,
      ),
      child: Stack(
        children: [
          CachedNetworkImage(
            height: 220,
            imageUrl: widget.store.bannerUrl ?? AppImages.logo,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(color: Colors.white),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),

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
                  backgroundColor: Colors.white, // белый фон
                  shape: const CircleBorder(), // круглая форма
                  padding: const EdgeInsets.all(12), // регулирует размер кнопки
                ),
              ),
            ),
          ),

          Align(
            alignment: AlignmentGeometry.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(12),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Название магазина
                  Text(
                    widget.store.name,
                    style: AppTextStyles.headline.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Логотип магазина
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.avatarMd),
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
                              const Icon(AppIcons.shop),
                        ),
                      ),

                      Text(
                        "${widget.store.rating} (${widget.store.reviewsCount})",
                        style: AppTextStyles.cardMainText.copyWith(
                          color: AppColors.white,
                        ),
                      ),

                      Text(
                        "Заказов: ${widget.store.totalOrders}",
                        style: AppTextStyles.cardMainText.copyWith(
                          color: AppColors.white,
                        ),
                      ),

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
    );
  }
}
