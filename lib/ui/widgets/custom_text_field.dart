import 'package:flutter/material.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_settings.dart';
import 'package:luma/global/params/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final bool isSuffixActive;
  final String hintText;
  final IconData icon;
  final void Function()? function;
  const CustomTextField({
    super.key,
    this.isSuffixActive = false,
    this.hintText = "hint text",
    this.icon = Icons.visibility,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.borderColor,
      style: AppTextStyles.text,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.text,

        isDense: true,
        contentPadding: null,

        suffixIcon: isSuffixActive
            ? IconButton(
                icon: Icon(icon, color: AppColors.textColor, size: 17.5),
                onPressed: function,
              )
            : null,

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.inactiveBorderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(AppSettings.borderAngle),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(AppSettings.borderAngle),
          ),
        ),
      ),
    );
  }
}
