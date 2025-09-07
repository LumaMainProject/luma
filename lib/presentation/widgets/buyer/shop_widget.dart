import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/constants/app_strings.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/data/models/user_profile.dart';
import 'package:luma_2/logic/user/user_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ShopWidget extends StatelessWidget {
  final Store store;
  final List<MapEntry<Product, CurrentOrder>> productOrders;

  const ShopWidget({
    super.key,
    required this.productOrders,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    // ---- считаем суммы ----
    final double productsTotal = productOrders.fold(
      0,
      (sum, entry) => sum + entry.value.totalPrice,
    );

    const double freeDeliveryThreshold = 50000; // порог для бесплатной доставки
    double deliveryCost = 15000;

    if (productsTotal >= freeDeliveryThreshold) {
      deliveryCost = 0;
    }

    final double grandTotal = productsTotal + deliveryCost;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SHOP HEADER
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.alterGray,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSizes.buttonRadius),
                topRight: Radius.circular(AppSizes.buttonRadius),
              ),
            ),
            child: Row(
              children: [
                // Лого
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                  child: CachedNetworkImage(
                    imageUrl: store.logoUrl!,
                    width: AppSizes.avatarSm,
                    height: AppSizes.avatarSm,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: AppSizes.avatarSm,
                        height: AppSizes.avatarSm,
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.shop),
                  ),
                ),

                const SizedBox(width: 10),

                // Название и кол-во товаров
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(store.name, style: AppTextStyles.text),
                    Text(
                      "${productOrders.length} ${AppStrings.buyerHomepageShopProducts}",
                      style: AppTextStyles.textButton,
                    ),
                  ],
                ),

                const Spacer(),

                // Общая сумма
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${grandTotal.toStringAsFixed(0)} ${AppStrings.currency}",
                      style: AppTextStyles.cardPrice,
                    ),
                    Text(
                      deliveryCost == 0
                          ? AppStrings.buyerHomepageShopFreeDelivery
                          : AppStrings.buyerHomepageShopWithDeliveryFee,
                      style: AppTextStyles.textButton,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ITEMS
          ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.paddingSm),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                ShopWidgetItem(item: productOrders[index]),
            separatorBuilder: (context, index) => AppSpacing.verticalSm,
            itemCount: productOrders.length,
          ),

          // BOTTOM
          Container(
            padding: const EdgeInsets.all(AppSpacing.paddingMd),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppSizes.buttonRadius),
                bottomRight: Radius.circular(AppSizes.buttonRadius),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.buyerHomepageShopProductsPrice,
                      style: AppTextStyles.cardSecondText,
                    ),
                    Text(
                      AppStrings.buyerHomepageShopDelivery,
                      style: AppTextStyles.cardSecondText,
                    ),
                    if (deliveryCost > 0)
                      Text(
                        "${AppStrings.buyerHomepageShopUntilFreeDelivery} ${(freeDeliveryThreshold - productsTotal).clamp(0, double.infinity).toStringAsFixed(0)} ${AppStrings.currency}",
                        style: AppTextStyles.cardSecondText,
                      ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${productsTotal.toStringAsFixed(0)} ${AppStrings.currency}",
                      style: AppTextStyles.buttonDeactive,
                    ),
                    Text(
                      deliveryCost == 0
                          ? AppStrings.buyerHomepageShopProductsDeliveryCost
                          : "${deliveryCost.toStringAsFixed(0)} ${AppStrings.currency}",
                      style: AppTextStyles.cardMainText,
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
}

class ShopWidgetItem extends StatelessWidget {
  final MapEntry<Product, CurrentOrder> item;
  const ShopWidgetItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final product = item.key;
    final order = item.value;

    return SizedBox(
      height: AppSizes.avatarLg,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Картинка
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              width: AppSizes.avatarLg,
              height: AppSizes.avatarLg,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: AppSizes.avatarLg,
                height: AppSizes.avatarLg,
                color: Colors.grey.shade200,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),

          AppSpacing.horizontalMd,

          // Название и цены
          Expanded(
            child: SizedBox(
              height: AppSizes.avatarLg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.cardMainText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.discountPrice != null)
                        Text(
                          "${product.discountPrice} ${AppStrings.currency}",
                          style: AppTextStyles.cardDiscountPrice,
                        ),
                      Text(
                        "${product.price} ${AppStrings.currency}",
                        style: AppTextStyles.cardPrice,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          AppSpacing.horizontalMd,

          // Управление заказом
          Align(
            alignment: Alignment.centerRight,
            child: QuantitySelector(
              count: order.quantity,
              onAdd: () {
                context.read<UserBloc>().add(
                  UpdateProductQuantity(product: product, delta: 1),
                );
              },
              onRemove: () {
                if (order.quantity > 0) {
                  context.read<UserBloc>().add(
                    UpdateProductQuantity(product: product, delta: -1),
                  );
                }
              },
              onDelete: () {
                context.read<UserBloc>().add(
                  UpdateProductQuantity(
                    product: product,
                    delta: -order.quantity,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final int count;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const QuantitySelector({
    super.key,
    required this.count,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 28,
          height: 28,
          child: IconButton(
            icon: Icon(AppIcons.delete, color: AppColors.borderColor, size: 12),
            onPressed: onDelete,
          ),
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 14,
                onPressed: onRemove,
                icon: Icon(AppIcons.remove, color: AppColors.borderColor),
              ),
            ),

            const SizedBox(width: 12),

            Text("$count", style: AppTextStyles.text),

            const SizedBox(width: 12),

            SizedBox(
              width: 28,
              height: 28,
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 14,
                onPressed: onAdd,
                icon: Icon(AppIcons.add, color: AppColors.borderColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
