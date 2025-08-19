import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/global/params/app_settings.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/pages/page_register.dart';
import 'package:luma/ui/widgets/custom_text_field.dart';
import 'package:luma/ui/widgets/delivery_button_widget.dart';

class BuyerFinalizeOrder extends StatelessWidget {
  const BuyerFinalizeOrder({super.key});

  @override
  Widget build(BuildContext context) {
    bool checkBoxValue = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("Оформление заказа", style: AppTextStyles.secondTitle),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: AppButtonStyle.cartShopWidget,
                  padding: EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Товары в заказе (4)",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.itemBigTitle,
                          ),
                          IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.arrow_downward_rounded,
                              color: AppColors.iconColor,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Checkbox(
                            value: checkBoxValue,
                            onChanged: (value) {},
                            side: BorderSide(color: AppColors.borderColor),
                            checkColor: AppColors.borderColor,
                          ),

                          Expanded(
                            child: Text(
                              "Подтверждаю, что выбранные товары и размеры верны",
                              style: AppTextStyles.shopCartDescription,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 34),

                // LOCATION
                Container(
                  decoration: AppButtonStyle.cartShopWidget,
                  padding: EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Адрес доставки",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.itemBigTitle,
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.125,
                              decoration: BoxDecoration(
                                color: AppColors.secondColor,
                                borderRadius: BorderRadius.circular(
                                  AppSettings.borderAngle,
                                ),
                              ),
                              child: Icon(
                                Icons.location_on_outlined,
                                size: 28,
                                color: AppColors.mainColor,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Address text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Основной адрес",
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.orderAddressTitle,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Ташкент, ул. Амира Темура,\n15, кв. 24",

                                  style: AppTextStyles.shopCartDescription,
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Подъезд 2, домофон 24",
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.shopCartTag,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          TextButton(
                            style: AppButtonStyle.textMinorButton,
                            onPressed: () {},
                            child: Text(
                              "Изменить",
                              style: AppTextStyles.textButtonMinor,
                            ),
                          ),

                          const SizedBox(width: 20),

                          TextButton(
                            style: AppButtonStyle.textMinorButton,
                            onPressed: () {},
                            child: Text(
                              "Добавить новый",
                              style: AppTextStyles.textButtonMinor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Checkbox(
                            value: checkBoxValue,
                            onChanged: (value) {},
                            side: BorderSide(color: AppColors.borderColor),
                            checkColor: AppColors.borderColor,
                          ),

                          Expanded(
                            child: Text(
                              "Подтверждаю, что адрес указан верно",
                              style: AppTextStyles.shopCartDescription,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Курьер позвонит перед доставкой",
                        style: AppTextStyles.shopCartTag,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 34),

                const Text(
                  "Способ доставки",
                  style: AppTextStyles.itemBigTitle,
                ),

                const SizedBox(height: 14),

                GestureDetector(
                  onTap: () {},
                  child: DeliveryButtonWidget(isTag: true),
                ),

                const SizedBox(height: 10),

                GestureDetector(
                  onTap: () {},
                  child: DeliveryButtonWidget(
                    title: "Быстрая 3-4 часа",
                    time: "До 21:00",
                    price: "+15.000 сум",
                  ),
                ),

                const SizedBox(height: 20),

                const Text("Способ оплаты", style: AppTextStyles.itemBigTitle),

                const SizedBox(height: 14),

                Row(
                  children: [
                    PageRegisterCustomButton(
                      isActive: false,
                      text: "Наличные",
                      icon: AppIcons.cash,
                      function: () {},
                    ),

                    const SizedBox(width: 10),

                    PageRegisterCustomButton(
                      isActive: true,
                      text: "Картой онлайн",
                      icon: AppIcons.card,
                      function: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                const Text("Оплатить через", style: AppTextStyles.itemBigTitle),

                const SizedBox(height: 14),

                Row(
                  children: [
                    PageRegisterCustomButton(
                      isActive: false,
                      text: "PayMe",
                      isIcon: false,
                      function: () {},
                    ),

                    const SizedBox(width: 10),

                    PageRegisterCustomButton(
                      isActive: true,
                      text: "Click",
                      isIcon: false,
                      function: () {},
                    ),

                    const SizedBox(width: 10),

                    PageRegisterCustomButton(
                      isActive: false,
                      text: "Uzum",
                      isIcon: false,
                      function: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3.5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondColor,
                    borderRadius: BorderRadius.circular(
                      AppSettings.borderAngle,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.new_releases_outlined,
                        color: AppColors.saleColor,
                      ),
                      const SizedBox(width: 10),
                      const Flexible(
                        child: Text(
                          "Онлайн оплата в разработке, доступна оплата наличными",
                          style: AppTextStyles.itemShopName,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Комментарий курьеру",
                  style: AppTextStyles.itemBigTitle,
                ),

                const SizedBox(height: 14),

                CustomTextField(
                  function: () {},
                  hintText: "Например: позвонить за 10 минут",
                ),

                // SIZEDBOX to correct work with STACK and dont block alignment
                const SizedBox(height: 100),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: AppButtonStyle.customBottomNavBar,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: 80,

              child: Container(
                decoration: AppButtonStyle.customBottomNavBarFix,
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("ИТОГО", style: AppTextStyles.itemBigTitle),
                        Text("745.000 сум", style: AppTextStyles.itemBigTitle),
                      ],
                    ),

                    const Spacer(),

                    TextButton(
                      style: AppButtonStyle.textMajorButton,
                      onPressed: () {
                      },
                      child: Text(
                        "Заказать",
                        style: AppTextStyles.textButtonMajor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
