import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/order_status.dart';
import 'package:luma_2/data/models/user_profile.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/logic/products/products_cubit.dart';
import 'package:luma_2/presentation/widgets/buyer/item_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InTrackOrderWidget extends StatelessWidget {
  final CurrentOrder order;
  const InTrackOrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final status = OrderStatusExtension.fromString(order.status);

    // 🔹 Безопасная конвертация даты
    final formattedDate = DateFormat(
      'dd.MM.yyyy HH:mm',
    ).format(order.updatedAt.toDate());

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок заказа
            Row(
              children: [
                Text("Заказ #${order.id}", style: AppTextStyles.cardMainText),
                const Spacer(),
                ItemWidgetTag(text: status.label),
              ],
            ),
            const SizedBox(height: 8),

            // Дата + сумма
            Row(
              children: [
                Text(formattedDate, style: const TextStyle(color: Colors.grey)),
                const Spacer(),
                Text("${order.totalPrice} сум"),
              ],
            ),

            const SizedBox(height: 12),

            Text("Товары", style: AppTextStyles.cardMainText),
            const SizedBox(height: 8),

            // Достаём продукт
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoaded) {
                  final product = state.products.firstWhere(
                    (p) => p.id == order.productId,
                    orElse: () => Product(
                      id: "",
                      title: "",
                      name: "Неизвестный товар",
                      description: "",
                      article: "",
                      category: "",
                      type: "",
                      brand: "",
                      countryOfOrigin: "",
                      price: 0,
                      imageUrl: "",
                      sellerId: "",
                      createdAt: Timestamp.now(),
                      updatedAt: Timestamp.now(),
                    ),
                  );

                  if (product.id.isEmpty) {
                    return const Text("Товар не найден");
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.avatarSm),
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
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),

                      const SizedBox(width: AppSpacing.paddingSm),

                      // 🔹 Блок с названием/описанием
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: AppTextStyles.cardMainText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.description,
                              style: AppTextStyles.cardSecondText,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // 🔹 Количество и цена
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Товаров: ${order.quantity}",
                            style: AppTextStyles.cardPrice,
                          ),
                          Text(
                            "${order.totalPrice} сум",
                            style: AppTextStyles.cardPrice,
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state is ProductsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Text("Ошибка загрузки товара");
                }
              },
            ),

            const SizedBox(height: 12),

            // Кнопки
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Детали"),
                  ),
                ),
                const SizedBox(width: AppSpacing.paddingMd),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Трек"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
