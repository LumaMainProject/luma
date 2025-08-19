import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/widget_tag.dart';

class DeliveryButtonWidget extends StatelessWidget {
  final String time;
  final String title;
  final String price;
  final String tag;
  final bool isTag;
  const DeliveryButtonWidget({
    super.key,
    this.tag = "Сегодня",
    this.isTag = false,
    this.price = "+30.000 сум",
    this.time = "до 16:00",
    this.title = "Экспресс 1-2 часа"
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppButtonStyle.cartShopWidget,
      padding: EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.itemBigTitle,
              ),
    
              Text(time, style: AppTextStyles.textButtonMinor),
            ],
          ),
    
          const SizedBox(width: 8),
    
          isTag ? WidgetTag(
            text: tag,
            color: AppColors.mainColor,
            style: AppTextStyles.itemHint,
          ) : const SizedBox(),
    
          const Spacer(),
    
          Text(price, style: AppTextStyles.textButtonOutcast),
        ],
      ),
    );
  }
}
