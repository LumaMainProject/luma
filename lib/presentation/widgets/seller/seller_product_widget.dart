import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/router/app_routes.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/logic/seller_add_product/seller_add_product_bloc.dart';
import 'package:luma_2/presentation/widgets/buyer/item_widget.dart';
import 'package:shimmer/shimmer.dart';

class SellerProductWidget extends StatelessWidget {
  final Product product;
  final Store store;
  const SellerProductWidget({
    super.key,
    required this.product,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение продукта
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
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
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),

            AppSpacing.horizontalMd,

            // Информация о продукте
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Название и рейтинг
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: AppTextStyles.cardMainText,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ItemWidgetTag(
                        text: product.ratingCount.toString(),
                        color: AppColors.graphUp,
                      ),
                    ],
                  ),

                  AppSpacing.verticalSm,

                  // ID и остаток
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.id, style: AppTextStyles.cardSecondText),
                      Text(
                        "Остаток: ${product.stock}",
                        style: AppTextStyles.cardSecondText,
                      ),
                    ],
                  ),

                  AppSpacing.verticalSm,

                  // Цена и действия
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.price.toString(),
                        style: AppTextStyles.cardPrice,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(AppIcons.sellerProductView),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<SellerAddProductBloc>().add(
                                InitProductForm(store: store, product: product),
                              );
                              context.pushNamed(
                                AppRoute.sellerAddPage.name,
                                extra: {"store": store, "product": product},
                              );
                            },
                            icon: Icon(AppIcons.sellerProductEdit),
                          ),

                          IconButton(
                            onPressed: () {},
                            icon: Icon(AppIcons.sellerProductOptions),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
