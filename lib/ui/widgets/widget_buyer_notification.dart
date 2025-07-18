import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_notification.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_notifications_status.dart';
import 'package:luma/global/params/app_text_styles.dart';

class WidgetBuyerNotification extends StatelessWidget {
  final ObjectNotification notification;
  const WidgetBuyerNotification({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: AppColors.vanillaIce,
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
            child: Image(
              image: notification.item.images[0],
              fit: BoxFit.fill,
              width: 60,
              height: 60,
            ),
          ),

          const SizedBox(width: 16),

          // Order confirmation
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppNotificationsStatusMap.appNotificationsStatusMap[notification
                        .status] ??
                    "Error", maxLines: 1, style: AppTextStyles.description,
              ),

              Text(notification.item.itemName, maxLines: 1,),
            ],
          ),

          Spacer(),

          // Amount and price text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Кол-во", maxLines: 1,), Text("Сумма", maxLines: 1,)],
          ),

          const SizedBox(width: 16),

          // Amount and price params
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                notification.amount.toString(),
                style: AppTextStyles.description,
                maxLines: 1,
              ),
              Text(
                "${notification.amount * notification.item.price}",
                style: AppTextStyles.description,
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
