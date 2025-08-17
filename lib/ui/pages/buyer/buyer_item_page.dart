import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/color_selector_grid.dart';
import 'package:luma/ui/widgets/custom_grid_view.dart';
import 'package:luma/ui/widgets/custom_item_widget.dart';
import 'package:luma/ui/widgets/custom_review_widget.dart';

class BuyerItemPage extends StatelessWidget {
  final String title;
  const BuyerItemPage({super.key, this.title = "title"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                iconTheme: IconThemeData(color: AppColors.iconColor),
                title: Text(title, style: AppTextStyles.secondTitle),
                centerTitle: true,
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(AppIcons.shadeIOS)),
                ],
              ),

              // IMAGE
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 14),
                  color: Colors.amber,
                  height: 680,
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(32),
                        ),
                        child: Container(
                          width: 32,
                          height: 32,
                          color: Colors.amber,
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text("Facsion Co", style: AppTextStyles.itemBigTitle),

                      Spacer(),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          AppIcons.favorite,
                          color: AppColors.iconColor,
                        ),
                      ),

                      Text("320", style: AppTextStyles.itemTitle),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: BuyerItemPageNamingWidget()),

              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              SliverToBoxAdapter(
                child: Container(
                  decoration: AppButtonStyle.buyerItemPage,
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Text(
                        "Сейчас: 280.000 сум",
                        style: AppTextStyles.itemPagePrice,
                      ),

                      const Spacer(),

                      Text(
                        "350.000 сум",
                        style: AppTextStyles.itemPagePriceOff,
                      ),

                      const SizedBox(width: 10),

                      Container(
                        decoration: AppButtonStyle.sale,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Text(
                          "-30%",
                          style: AppTextStyles.itemPagePriceSale,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Цвет", style: AppTextStyles.itemBigTitle),
                      SizedBox(
                        height: 30,
                        child: ColorSelectorGrid(
                          colors: [
                            AppColors.saleColor,
                            AppColors.vanillaIce,
                            AppColors.inactiveBorderColor,
                          ],
                          onColorSelected: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              SliverPadding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 14),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "Платье из лёгкой вискозы с поясом. Мягкая посадка, длина миди. Подходит для повседневных и вечерних образов. Рекомендуем ручную стирку.",
                    style: AppTextStyles.text,
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 14),
                  child: Text(
                    "Характеристики",
                    style: AppTextStyles.itemBigTitle,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsetsGeometry.all(14),
                  padding: const EdgeInsetsGeometry.all(14),
                  decoration: AppButtonStyle.customBottomNavBar,
                  child: Column(
                    children: [
                      BuildPositionItem(category: "Тип", data: "Платье"),

                      Divider(color: AppColors.inactiveBorderColor),

                      BuildPositionItem(
                        category: "Цвета",
                        data: "Черный, Бежевый, Розовый",
                      ),

                      Divider(color: AppColors.inactiveBorderColor),

                      BuildPositionItem(
                        category: "Материал",
                        data: "Вискоза 70%, ПЭ 30%",
                      ),

                      Divider(color: AppColors.inactiveBorderColor),

                      BuildPositionItem(
                        category: "Размерная сетка",
                        data: "EU",
                      ),

                      Divider(color: AppColors.inactiveBorderColor),

                      BuildPositionItem(
                        category: "Категория",
                        data: "Женская одежда",
                      ),

                      Divider(color: AppColors.inactiveBorderColor),

                      BuildPositionItem(
                        category: "Страна производства",
                        data: "Турция",
                      ),

                      Divider(color: AppColors.inactiveBorderColor),

                      BuildPositionItem(
                        category: "Артикул",
                        data: "LUM - 5842",
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Отзывы 4.8 (1.245)",
                        style: AppTextStyles.itemBigTitle,
                      ),
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
                  height: 180,
                  child: CustimGridView(
                    itemHeight: 180,
                    itemWidth: 280,
                    itemBuilder: (context, index) {
                      return CustomReviewWidget();
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Другие товары магазина",
                        style: AppTextStyles.itemBigTitle,
                      ),
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
                      return CustomItemWidget(isShopShowed: false);
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Похожие товары", style: AppTextStyles.itemBigTitle),
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
                      return CustomItemWidget();
                    },
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: AppButtonStyle.customBottomNavBar,
              margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              padding: const EdgeInsets.all(14),
              height: 80,

              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("ИТОГО", style: AppTextStyles.itemBigTitle),
                      Text("280.000 сум", style: AppTextStyles.itemBigTitle),
                    ],
                  ),

                  const Spacer(),

                  TextButton(
                    style: AppButtonStyle.textMiddleButton,
                    onPressed: () {},
                    child: Text("В корзину", style: AppTextStyles.itemBigTitle),
                  ),

                  const SizedBox(width: 8),

                  TextButton(
                    style: AppButtonStyle.textMajorButton,
                    onPressed: () {},
                    child: Text(
                      "Купить сейчас",
                      style: AppTextStyles.textButtonMajor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuyerItemPageNamingWidget extends StatelessWidget {
  const BuyerItemPageNamingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("TITLE", style: AppTextStyles.secondTitle),
          Row(
            children: [
              const Icon(
                AppIcons.raitings,
                color: AppColors.iconColor,
                size: 12,
              ),

              const SizedBox(width: 4),

              Text("4.8", style: AppTextStyles.textButtonMinor),

              const SizedBox(width: 4),

              Text("(1.245)", style: AppTextStyles.textButtonMinor),

              const SizedBox(width: 14),
              Text("•", style: AppTextStyles.textButtonMinor),
              const SizedBox(width: 14),

              const Icon(
                AppIcons.favorite,
                color: AppColors.iconColor,
                size: 12,
              ),
              const SizedBox(width: 4),
              Text("320", style: AppTextStyles.itemTitle),

              const SizedBox(width: 14),
              Text("•", style: AppTextStyles.textButtonMinor),
              const SizedBox(width: 14),

              const Text("ЗАКАЗОВ:", style: AppTextStyles.itemTitle),
              const SizedBox(width: 4),
              Text("2.140", style: AppTextStyles.itemTitle),
            ],
          ),
        ],
      ),
    );
  }
}

class BuildPositionItem extends StatelessWidget {
  final String category;
  final String data;
  const BuildPositionItem({
    super.key,
    this.category = "category",
    this.data = "data",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(category, style: AppTextStyles.itemPrice),
        Text(data, style: AppTextStyles.raitings),
      ],
    );
  }
}
