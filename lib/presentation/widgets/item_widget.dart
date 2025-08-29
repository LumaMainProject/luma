import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luma_2/core/router/app_routes.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:shimmer/shimmer.dart';

class ItemWidget extends StatelessWidget {
  final Product product;
  final Store store;
  final double? width;
  final String? customText;

  const ItemWidget({
    super.key,
    required this.product,
    required this.store,
    this.width,
    this.customText,
  });

  @override
  Widget build(BuildContext context) {
    String? tagText = customText;
    if (tagText == null || tagText.isEmpty) {
      if (product.discountPrice != null && product.discountPrice! > 0) {
        final discountPercent =
            ((1 - (product.discountPrice! / product.price)) * 100).round();
        tagText = "$discountPercent%";
      }
    }

    Widget storeLogo = store.logoUrl != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.avatarSm),
            child: CachedNetworkImage(
              imageUrl: store.logoUrl!,
              width: AppSizes.avatarESm,
              height: AppSizes.avatarESm,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: AppSizes.avatarESm,
                  height: AppSizes.avatarESm,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          )
        : const SizedBox();

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(
              AppRoute.buyerProduct.path,
              extra: {'product': product, 'store': store},
            );
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.paddingSm),
              child: SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Квадратное изображение
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppSizes.buttonRadius,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: product.imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(color: Colors.white),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.paddingSm),

                    // Логотип магазина и название + название продукта
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            storeLogo,
                            AppSpacing.horizontalXs,
                            Expanded(
                              child: Text(
                                store.name,
                                style: AppTextStyles.cardMainText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.paddingXs),
                        Text(
                          product.title,
                          style: AppTextStyles.cardMainText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                    // Заполнитель, чтобы цены были внизу
                    const Spacer(),

                    // Цены
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.discountPrice != null &&
                            product.discountPrice! > 0)
                          Text(
                            "${product.discountPrice} сум",
                            style: AppTextStyles.cardDiscountPrice,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (product.discountPrice != null &&
                            product.discountPrice! > 0)
                          const SizedBox(height: 4),
                        Text(
                          "${product.price} сум",
                          style: AppTextStyles.cardPrice,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Тег
        if (tagText != null && tagText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.paddingSm),
            child: ItemWidgetTag(text: tagText),
          ),
      ],
    );
  }
}

class ItemWidgetTag extends StatelessWidget {
  final String text;

  const ItemWidgetTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingXs,
        vertical: AppSpacing.paddingAs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: AppTextStyles.cardTag,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
