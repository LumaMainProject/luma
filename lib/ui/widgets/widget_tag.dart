import 'package:flutter/material.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_settings.dart';
import 'package:luma/global/params/app_text_styles.dart';

class WidgetTag extends StatelessWidget {
  final String text;
  final Color color;
  final TextStyle style;
  const WidgetTag({
    super.key,
    this.text = "TAG",
    this.color = AppColors.cartBorder,
    this.style = AppTextStyles.shopCartTag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSettings.borderAngle),
      ),
      child: Text(text, style:style),
    );
  }
}
