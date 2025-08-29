import 'package:flutter/material.dart';
import 'package:luma_2/core/constants/app_strings.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/product.dart';

class ProductPriceBlock extends StatelessWidget {
  final Product product;

  const ProductPriceBlock({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.secondary,
      ),
      child: Row(
        children: [
          Text("${product.price} ${AppStrings.currency}", style: AppTextStyles.headline),
          const Spacer(),
          if (product.discountPrice != null) ...[
            Text(
              "${product.discountPrice} ${AppStrings.currency}",
              style: AppTextStyles.text.copyWith(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            AppSpacing.horizontalSm,
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppSizes.buttonRadius / 2),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingSm,
                vertical: AppSpacing.paddingXs,
              ),
              child: Text(
                "-${_calcDiscount(product)}%",
                style: AppTextStyles.text.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }

  int _calcDiscount(Product product) {
    if (product.discountPrice == null || product.discountPrice == 0) return 0;
    final discount = 100 - ((product.price / product.discountPrice!) * 100).round();
    return discount;
  }
}
