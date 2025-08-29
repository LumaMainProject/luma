import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart'; // для firstWhereOrNull
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/constants/app_strings.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/logic/user/user_bloc.dart';

class BottomBuyBar extends StatelessWidget {
  final Product product;

  const BottomBuyBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.paddingMd),
      height: AppSizes.buttonBar,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Container(
        height: AppSizes.buttonBar,
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        ),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            int quantityInCart = 0;

            if (state is UserLoaded) {
              final currentOrder = state.user.currentOrders.firstWhereOrNull(
                (o) => o.productId == product.id,
              );
              quantityInCart = currentOrder?.quantity ?? 0;
            }

            return Row(
              children: [
                // Левая часть
                quantityInCart == 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.buyerProductScreenSummary,
                            style: AppTextStyles.text,
                          ),
                          Text(
                            "${product.price} ${AppStrings.currency}",
                            style: AppTextStyles.headline,
                          ),
                        ],
                      )
                    : IconButton(
                        icon: const Icon(AppIcons.remove),
                        onPressed: () {
                          context.read<UserBloc>().add(
                            UpdateProductQuantity(product: product, delta: -1),
                          );
                        },
                      ),

                const Spacer(),

                // Средняя часть — количество при >0, пусто при 0
                if (quantityInCart > 0)
                  Text(
                    quantityInCart.toString(),
                    style: AppTextStyles.headline,
                  ),

                if (quantityInCart > 0) const Spacer(),

                // Правая часть — корзина при 0, "+" при >0
                IconButton(
                  icon: Icon(
                    quantityInCart == 0 ? AppIcons.shop : AppIcons.add,
                  ),
                  onPressed: () {
                    context.read<UserBloc>().add(
                      UpdateProductQuantity(product: product, delta: 1),
                    );
                  },
                ),

                const SizedBox(width: AppSpacing.paddingMd),

                // Кнопка "Купить сейчас"
                SizedBox(
                  width: AppSizes.productMd,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(AppStrings.buyerProductScreenBuy),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
