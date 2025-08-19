import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/global/params/app_router.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/circle_icon_button.dart';
import 'package:luma/ui/widgets/custom_grid_view.dart';
import 'package:luma/ui/widgets/custom_item_widget.dart';
import 'package:luma/ui/widgets/custom_text_field.dart';

class PageBuyerHomepage extends StatefulWidget {
  const PageBuyerHomepage({super.key});

  @override
  State<PageBuyerHomepage> createState() => _PageBuyerHomepageState();
}

class _PageBuyerHomepageState extends State<PageBuyerHomepage> {
  void showWarningPopup(
    BuildContext context, {
    String title = "Внимание",
    String message = "Что-то пошло не так",
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            backgroundColor: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              //height: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6), // space around icon
                    decoration: BoxDecoration(
                      color: AppColors.secondColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      AppIcons.photoMode,
                      size: 20,
                      color: AppColors.mainColor,
                    ),
                  ),

                  const SizedBox(height: 8),
                  Text(title, style: AppTextStyles.secondTitle),
                  const SizedBox(height: 8),
                  Text(message, style: AppTextStyles.itemPrice),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    child: TextButton(
                      onPressed: null,
                      style: AppButtonStyle.deactiveRegisterPageButton,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            AppIcons.gallery,
                            size: 28,
                            color: AppColors.secondColor,
                          ),
                          const SizedBox(
                            height: 6,
                          ), // spacing between icon and text
                          Text(
                            "Загрузить фото",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.secondColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    child: TextButton(
                      onPressed: null,
                      style: AppButtonStyle.deactiveRegisterPageButton,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            AppIcons.photoMode,
                            size: 28,
                            color: AppColors.secondColor,
                          ),
                          const SizedBox(
                            height: 6,
                          ), // spacing between icon and text
                          Text(
                            "Открыть камеру",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.secondColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: AppButtonStyle.textMajorButton,
                      child: const Text(
                        "Понятно",
                        style: AppTextStyles.textButtonMajor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: null,
                      style: AppButtonStyle.textMinorButton,
                      child: const Text(
                        "Посмотреть демо (скоро)",
                        style: AppTextStyles.textButtonMinor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        shadowColor: Colors.black12,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRouter.names[AppRouterEnum.routerBuyerNotifications]!,
            );
          },
          icon: Icon(AppIcons.notifications, color: AppColors.mainColor),
        ),

        title: Text("LUMA", style: AppTextStyles.logo),
        centerTitle: true,

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60), // height of search bar
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: CustomTextField(
              hintText: "Поикс товаров, брендов, магазинов...",
              isSuffixActive: true,
              icon: AppIcons.photoMode,
              function: () {
                showWarningPopup(
                  context,
                  title: "Фото режим",
                  message:
                      "Мы работаем над функцией распознавания вещей по фото.",
                );
              },
            ),
          ),
        ),
      ),

      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // First Grid
          SizedBox(
            height: 82 * 1.5,
            child: CustimGridView(
              multiplier: 1.5,
              itemWidth: 60,
              itemBuilder: (context, index) {
                return CircleIconButton(
                  icon: AppIcons.account,
                  label: "TEST",
                  onPressed: () {},
                  size: 60,
                  isFavorite: index == 0,
                  isActive: index % 2 == 0 && index != 0,
                );
              },
            ),
          ),

          // SALES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Скидки", style: AppTextStyles.secondTitle),
                TextButton(
                  onPressed: () {},
                  style: AppButtonStyle.textMinorButton,
                  child: Text(
                    "Смотреть всё >",
                    style: AppTextStyles.textButtonOutcast,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 208,
            width: 128,
            child: CustimGridView(
              itemHeight: 208,
              itemWidth: 128,
              itemBuilder: (context, index) {
                return CustomItemWidget(
                  isSale: true,
                  isHint: true,
                  hintContext: "-30%",
                );
              },
            ),
          ),

          // SEASON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Хит сезона 2025", style: AppTextStyles.secondTitle),
                TextButton(
                  onPressed: () {},
                  style: AppButtonStyle.textMinorButton,
                  child: Text(
                    "Смотреть всё >",
                    style: AppTextStyles.textButtonOutcast,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 208,
            width: 156,
            child: CustimGridView(
              itemHeight: 208,
              itemWidth: 156,
              itemBuilder: (context, index) {
                return CustomItemWidget(isHint: true, hintContext: "Hit '25");
              },
            ),
          ),

          // RECOMMENDATIONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Рекомендации вам", style: AppTextStyles.secondTitle),
                TextButton(
                  onPressed: () {},
                  style: AppButtonStyle.textMinorButton,
                  child: Text(
                    "Смотреть всё >",
                    style: AppTextStyles.textButtonOutcast,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.78181818181,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return CustomItemWidget(isBig: true, isRaitingsShowed: true);
              },
            ),
          ),

          // POPULAR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Популярное", style: AppTextStyles.secondTitle),
                TextButton(
                  onPressed: () {},
                  style: AppButtonStyle.textMinorButton,
                  child: Text(
                    "Смотреть всё >",
                    style: AppTextStyles.textButtonOutcast,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.78181818181,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                return CustomItemWidget(isBig: true, isRaitingsShowed: true);
              },
            ),
          ),

          const SizedBox(height: 108),
        ],
      ),
    );
  }
}
