import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/presentation/widgets/buyer_product_widgets/bottom_buy_bar.dart';
import 'package:luma_2/presentation/widgets/buyer_product_widgets/product_description.dart';
import 'package:luma_2/presentation/widgets/buyer_product_widgets/product_image.dart';
import 'package:luma_2/presentation/widgets/buyer_product_widgets/product_price_block.dart';
import 'package:luma_2/presentation/widgets/buyer_product_widgets/product_reviews.dart';
import 'package:luma_2/presentation/widgets/buyer_product_widgets/product_specs.dart';
import 'package:luma_2/presentation/widgets/buyer_product_widgets/product_store_info.dart';
import 'package:luma_2/presentation/widgets/buyer_product_widgets/product_title.dart';

class BuyerPruductScreen extends StatelessWidget {
  final Product product;
  final Store store;

  const BuyerPruductScreen({
    super.key,
    required this.product,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.white,
                iconTheme: const IconThemeData(color: AppColors.textDark),
                title: Text(product.title, style: AppTextStyles.headline),
                centerTitle: true,
                pinned: true,
              ),

              SliverToBoxAdapter(
                child: ProductImage(imageUrl: product.imageUrl),
              ),

              SliverToBoxAdapter(
                child: ProductStoreInfo(store: store, product: product),
              ),

              SliverToBoxAdapter(
                child: ProductTitle(product: product),
              ),

              SliverToBoxAdapter(child: ProductPriceBlock(product: product)),

              SliverToBoxAdapter(
                child: ProductDescription(description: product.description),
              ),

              if (product.specs != null && product.specs!.isNotEmpty)
                SliverToBoxAdapter(child: ProductSpecs(specs: product.specs!)),

              SliverToBoxAdapter(
                child: ProductReviews(reviews: product.reviews),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.bottomButtonBar),
              ),
            ],
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: BottomBuyBar(product: product),
          ),
        ],
      ),
    );
  }
}
