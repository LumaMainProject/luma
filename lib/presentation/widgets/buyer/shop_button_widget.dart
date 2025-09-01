import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:shimmer/shimmer.dart';

class ShopButtonWidget extends StatelessWidget {
  final Store store;
  const ShopButtonWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpacing.verticalSm,
        
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          child: CachedNetworkImage(
            imageUrl: store.logoUrl!,
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
            errorWidget: (context, url, error) => const Icon(Icons.shop),
          ),
        ),

        AppSpacing.verticalSm,

        Text(store.name, style: AppTextStyles.cardMainText),
      ],
    );
  }
}
