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
import 'package:luma_2/logic/user/user_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ProductStoreInfo extends StatefulWidget {
  final Store store;
  final Product product;
  final VoidCallback? onGuestAction;

  const ProductStoreInfo({
    super.key,
    required this.store,
    required this.product,
    this.onGuestAction,
  });

  @override
  State<ProductStoreInfo> createState() => _ProductStoreInfoState();
}

class _ProductStoreInfoState extends State<ProductStoreInfo> {
  bool? _localFavorite;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userState = context.read<UserBloc>().state;
    if (_localFavorite == null && userState is UserLoaded) {
      _localFavorite = userState.user.favoriteProducts.contains(
        widget.product.id,
      );
    }
  }

  void _toggleFavorite() {
    final userState = context.read<UserBloc>().state;
    if (userState is UserLoaded) {
      setState(() {
        _localFavorite = !(_localFavorite ?? false);
      });

      // Отправляем событие в UserBloc для обновления на сервере
      if (_localFavorite == true) {
        context.read<UserBloc>().add(AddToFavorites(widget.product.id));
      } else {
        context.read<UserBloc>().add(RemoveFromFavorites(widget.product.id));
      }
    } else if (widget.onGuestAction != null) {
      widget.onGuestAction!();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Для избранного нужно войти в аккаунт')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = _localFavorite;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingMd),
      child: InkWell(
        onTap: () {
          context.pushNamed(AppRoute.buyerShopScreen.name, extra: widget.store);
        },
        child: Row(
          children: [
            // Логотип магазина
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.avatarSm),
              child: CachedNetworkImage(
                imageUrl: widget.store.logoUrl ?? '',
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
                errorWidget: (context, url, error) => const Icon(AppIcons.shop),
              ),
            ),
            AppSpacing.horizontalSm,
            // Название магазина
            Expanded(
              child: Text(widget.store.name, style: AppTextStyles.headline),
            ),

            // Кнопка избранного
            IconButton(
              onPressed: _toggleFavorite,
              icon: Icon(
                isFavorite == true ? Icons.favorite : Icons.favorite_border,
                color: isFavorite == true
                    ? AppColors.primary
                    : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
