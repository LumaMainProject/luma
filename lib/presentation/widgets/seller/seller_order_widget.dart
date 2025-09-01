import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/order_status.dart';
import 'package:luma_2/data/models/user_profile.dart';
import 'package:luma_2/presentation/widgets/buyer/item_widget.dart';

class SellerOrderWidget extends StatelessWidget {
  final CurrentOrder order;
  const SellerOrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // преобразуем raw string в OrderStatus
    final status = OrderStatusExtension.fromString(order.status).label;

    // форматируем дату
    final dateFormatter = DateFormat(
      'dd.MM.yyyy HH:mm',
    ); // день.месяц.год часы:минуты
    final formattedDate = dateFormatter.format(order.createdAt.toDate());

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Заказ ${order.id}", style: AppTextStyles.cardMainText),
                ItemWidgetTag(text: status),
              ],
            ),

            const SizedBox(height: 8),

            Text("${order.totalPrice} сум", style: AppTextStyles.cardPrice),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Кол-во: ${order.quantity}",
                  style: AppTextStyles.cardPrice,
                ),
                Text(formattedDate, style: AppTextStyles.cardPrice),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
