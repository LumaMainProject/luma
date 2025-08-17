import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/circle_icon_button.dart';
import 'package:luma/ui/widgets/custom_grid_view.dart';
import 'package:luma/ui/widgets/custom_item_widget.dart';
import 'package:luma/ui/widgets/custom_text_field.dart';

class PageBuyerHomepage extends StatelessWidget {
  const PageBuyerHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.whiteColor,
            shadowColor: Colors.black12,
            floating: true,
            scrolledUnderElevation: 0,

            leading: IconButton(
              onPressed: () {},
              icon: Icon(AppIcons.notifications, color: AppColors.mainColor),
            ),
            title: Text("LUMA", style: AppTextStyles.logo),
            centerTitle: true,

            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60), // height of search bar
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                child: CustomTextField(
                  hintText: "Поикс товаров, брендов, магазинов...",
                  isSuffixActive: true,
                  icon: AppIcons.photoMode,
                  function: () {},
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: (82 * 1.5),
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
          ),

          // SALES
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 14),
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
          ),

          SliverToBoxAdapter(
            child: SizedBox(
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
          ),

          // SEASON
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 14),
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
          ),

          SliverToBoxAdapter(
            child: SizedBox(
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
          ),

          // RECOMENDATIONS
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 14),
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
          ),

          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 14),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.78181818181,
              ),
              itemBuilder: (context, index) {
                return CustomItemWidget(isBig: true, isRaitingsShowed: true);
              },
              itemCount: 6,
            ),
          ),

          // RECOMENDATIONS
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
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
          ),

          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 14),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.78181818181,
              ),
              itemBuilder: (context, index) {
                return CustomItemWidget(isBig: true, isRaitingsShowed: true);
              },
              itemCount: 20,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 108)),
        ],
      ),
    );
  }
}
