import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_settings.dart';
import 'package:luma/global/params/app_text_styles.dart';

class NotificationWidget extends StatelessWidget {
  final bool isNew;
  const NotificationWidget({super.key, this.isNew = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSettings.borderAngle),
        child: Container(
          height: 92 + 14 + 14,
          decoration: AppButtonStyle.notification,

          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isNew
                      ? Container(width: 4, color: AppColors.mainColor)
                      : const SizedBox(width: 4),

                  const SizedBox(width: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(36),
                        ),
                        child: Container(color: Colors.amber),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Новый заказ", style: AppTextStyles.itemBigTitle),
                        Text(
                          "Urban подтвердил ваш заказ • 3 мин назад",
                          style: AppTextStyles.textButtonMinor,
                        ),
                        TextButton(
                          onPressed: () {},
                          style: AppButtonStyle.notificationsDeactive,
                          child: Text("Посмотреть", style: AppTextStyles.text),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isNew
                            ? const Icon(
                                Icons.circle,
                                color: AppColors.mainColor,
                                size: 14,
                              )
                            : const SizedBox(width: 14),
                        const SizedBox(width: 4),
                        Text("3 МИН >", style: AppTextStyles.textButtonMinor),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
