import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_text_styles.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color iconColor;
  final double size;
  final bool isActive;
  final bool isFavorite;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.iconColor = Colors.black,
    this.size = 60,
    this.isActive = false,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    BoxDecoration getBoxDecoration() {
      if (isFavorite) {
        return AppButtonStyle.circleIconIsFavorite;
      }

      if (isActive) {
        return AppButtonStyle.circleIconActive;
      } else {
        return AppButtonStyle.circleIconInActive;
      }
    }

    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: getBoxDecoration(),
            alignment: Alignment.center,
            child: Icon(icon, color: iconColor, size: size * 0.5),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.textButtonMinor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
