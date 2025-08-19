import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/notification_widget.dart';

class PageBuyerNotifications extends StatelessWidget {
  const PageBuyerNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      appBar: AppBar(
        title: Text("Уведомления", style: AppTextStyles.secondTitle),
        centerTitle: true,

        actions: [
          TextButton(
            onPressed: () {},
            child: Text("ПРОЧИТАННОЕ", style: AppTextStyles.itemPrice),
          ),
        ],

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80), // height of search bar
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: AppButtonStyle.notificationsActive,
                      child: Text("Все", style: AppTextStyles.textButtonMajor),
                    ),

                    const SizedBox(width: 8),

                    TextButton(
                      onPressed: () {},
                      style: AppButtonStyle.notificationsDeactive,
                      child: Text("Заказы", style: AppTextStyles.text),
                    ),

                    const SizedBox(width: 8),

                    TextButton(
                      onPressed: () {},
                      style: AppButtonStyle.notificationsDeactive,
                      child: Text("Доставка", style: AppTextStyles.text),
                    ),

                    const SizedBox(width: 8),

                    TextButton(
                      onPressed: () {},
                      style: AppButtonStyle.notificationsDeactive,
                      child: Text("В наличии", style: AppTextStyles.text),
                    ),

                    const SizedBox(width: 8),

                    TextButton(
                      onPressed: () {},
                      style: AppButtonStyle.notificationsDeactive,
                      child: Text("Промо", style: AppTextStyles.text),
                    ),
                  ],
                ),

                Text(
                  "СЕГОДНЯ, 14 АВГУСТА",
                  style: AppTextStyles.textButtonMinor,
                ),
              ],
            ),
          ),
        ),
      ),

      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 14),
        separatorBuilder: (context, index) {
          if (index == 0) {
            return Text("Сегодня", style: AppTextStyles.itemBigTitle);
          }
          if (index == 5) {
            return Text("Вчера", style: AppTextStyles.itemBigTitle);
          }
          if (index == 8) {
            return Text("На этой неделе", style: AppTextStyles.itemBigTitle);
          }
          return NotificationWidget(isNew: index == 2 || index == 1);
        },
        itemBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: 20,
      ),
    );
  }
}
