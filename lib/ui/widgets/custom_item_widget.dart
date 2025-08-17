import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/global/params/app_router.dart';
import 'package:luma/global/params/app_settings.dart';
import 'package:luma/global/params/app_text_styles.dart';

class CustomItemWidget extends StatelessWidget {
  final bool isSale;
  final bool isBig;
  final bool isHint;
  final bool isShopShowed;
  final bool isRaitingsShowed;
  final String hintContext;
  const CustomItemWidget({
    super.key,
    this.isSale = false,
    this.isBig = false,
    this.isHint = false,
    this.isShopShowed = true,
    this.isRaitingsShowed = false,
    this.hintContext = "hint",
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // CONTENT
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouter.names[AppRouterEnum.routerBuyerItemPage]!,
              arguments: BuyerItemPageArgs("Cool Jacket"),
            );
          },
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image container takes all free vertical space
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSettings.borderAngle),
                    ),
                    child: Container(
                      color: Colors.amber,
                      width: double.infinity,
                    ),
                  ),
                ),

                isShopShowed
                    ? Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(AppSettings.borderAngle),
                            ),
                            child: Container(
                              color: Colors.amber,
                              height: 14,
                              width: 14,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Shop Name",
                            maxLines: 1,
                            style: AppTextStyles.itemShopName,
                          ),
                        ],
                      )
                    : const SizedBox(),

                Text(
                  "Стильная куртка премиум качества",
                  maxLines: 2,
                  style: isBig
                      ? AppTextStyles.itemBigTitle
                      : AppTextStyles.itemTitle,
                ),

                isSale
                    ? Text(
                        "400.000 сум",
                        maxLines: 1,
                        style: AppTextStyles.itemSale,
                      )
                    : const SizedBox(),

                Text(
                  "280.000 сум",
                  maxLines: 1,
                  style: isBig
                      ? AppTextStyles.itemBigPrice
                      : AppTextStyles.itemPrice,
                ),

                isRaitingsShowed
                    ? Row(
                        children: [
                          Icon(AppIcons.raitings, color: AppColors.iconColor),
                          Text("4.8", style: AppTextStyles.raitings),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),

        // HINT
        isHint
            ? Container(
                decoration: AppButtonStyle.itemHint,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                margin: EdgeInsets.all(12),
                child: Text(hintContext, style: AppTextStyles.itemHint),
              )
            : const SizedBox(),

        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: Icon(AppIcons.favorite, size: 14),
            style: AppButtonStyle.itemButton,
          ),
        ),

        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsetsGeometry.only(top: 22 + 4),
            child: IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              icon: Icon(AppIcons.shopCart, size: 14),
              style: AppButtonStyle.itemButton,
            ),
          ),
        ),
      ],
    );
  }
}
