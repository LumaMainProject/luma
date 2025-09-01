import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/presentation/widgets/buyer/buyer_product_widgets/bottom_buy_bar.dart';
import 'package:luma_2/presentation/widgets/buyer/buyer_product_widgets/product_description.dart';
import 'package:luma_2/presentation/widgets/buyer/buyer_product_widgets/product_image.dart';
import 'package:luma_2/presentation/widgets/buyer/buyer_product_widgets/product_price_block.dart';
import 'package:luma_2/presentation/widgets/buyer/buyer_product_widgets/product_reviews.dart';
import 'package:luma_2/presentation/widgets/buyer/buyer_product_widgets/product_specs.dart';
import 'package:luma_2/presentation/widgets/buyer/buyer_product_widgets/product_store_info.dart';
import 'package:luma_2/presentation/widgets/buyer/buyer_product_widgets/product_title.dart';
import 'package:luma_2/presentation/widgets/buyer/item_widget.dart';

class BuyerProductScreen extends StatelessWidget {
  final Product product;
  final Store store;

  const BuyerProductScreen({
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

              SliverToBoxAdapter(child: ProductTitle(product: product)),

              SliverToBoxAdapter(child: ProductPriceBlock(product: product)),

              SliverToBoxAdapter(
                child: ProductDescription(description: product.description),
              ),

              if (product.specs != null && product.specs!.isNotEmpty)
                SliverToBoxAdapter(child: ProductSpecs(specs: product.specs!)),

              SliverToBoxAdapter(
                child: ProductReviews(reviews: product.reviews),
              ),

              // 🔹 товары этого магазина
              SliverToBoxAdapter(
                child: _ProductsCarousel(
                  title: "Товары этого магазина",
                  query: FirebaseFirestore.instance
                      .collection("products")
                      .where("sellerId", isEqualTo: store.id),
                  excludeId: product.id,
                ),
              ),

              // 🔹 популярные товары
              SliverToBoxAdapter(
                child: _ProductsCarousel(
                  title: "Популярные товары",
                  query: FirebaseFirestore.instance.collection("products"),
                  excludeId: product.id,
                ),
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

class _ProductsCarousel extends StatelessWidget {
  final String title;
  final Query query;
  final String? excludeId;

  const _ProductsCarousel({
    required this.title,
    required this.query,
    this.excludeId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        final products = snapshot.data!.docs
            .map(
              (d) => Product.fromJson(d.data() as Map<String, dynamic>, d.id),
            )
            .where((p) => excludeId == null || p.id != excludeId)
            .toList();

        if (products.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(title, style: AppTextStyles.headline),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: AppSizes.cartMd, // 🔹 чтобы ItemWidget красиво влезал
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, i) {
                    final p = products[i];

                    // 🔹 подтягиваем Store для каждого продукта (как на главной)
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection("stores")
                          .doc(p.sellerId)
                          .get(),
                      builder: (context, storeSnap) {
                        if (!storeSnap.hasData) {
                          return const SizedBox(width: AppSizes.productMd);
                        }

                        final store = Store.fromJson(
                          storeSnap.data!.data() as Map<String, dynamic>,
                          storeSnap.data!.id,
                        );

                        return ItemWidget(
                          product: p,
                          store: store,
                          width: AppSizes.productMd,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
