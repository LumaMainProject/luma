import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/product.dart';

class ProductTitle extends StatelessWidget {
  final Product product;

  const ProductTitle({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // ✅ теперь всё влево
        children: [
          /// Название товара
          Text(product.title, style: AppTextStyles.headline),

          AppSpacing.verticalXs,

          /// Статистика (рейтинг, избранное, заказы)
          Row(
            children: [
              Icon(Icons.star, size: 16, color: AppColors.primary),
              AppSpacing.horizontalXs,
              Text(
                "${product.rating} (${product.ratingCount})",
                style: AppTextStyles.text,
              ),

              AppSpacing.horizontalSm,

              Icon(Icons.favorite, size: 16, color: AppColors.secondary),
              AppSpacing.horizontalSm,
              Text("${product.favoritesCount}", style: AppTextStyles.text),

              AppSpacing.horizontalSm,

              Icon(Icons.shopping_cart, size: 16, color: AppColors.text),
              AppSpacing.horizontalSm,
              Text("${product.ordersCount}", style: AppTextStyles.text),
            ],
          ),
        ],
      ),
    );
  }
}
