import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/router/app_routes.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/store.dart';

class SellerQuickActions extends StatelessWidget {
  final Store store;
  final double height;
  const SellerQuickActions({super.key, this.height = 90, required this.store});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {
        "icon": AppIcons.add,
        "label": "ТОВАР",
        "onTap": () {
          context.pushNamed(
            AppRoute.sellerAddPage.name,
            extra: {"store": store},
          );
        },
      },
      {
        "icon": AppIcons.sellerContentVideo,
        "label": "СНЯТЬ ВИДЕО",
        "onTap": () {},
      },
      {
        "icon": AppIcons.sellerContentSale,
        "label": "СОЗДАТЬ СКИДКУ",
        "onTap": () {},
      },
      {
        "icon": AppIcons.sellerContentAdjust,
        "label": "ПРОДВИНУТЬ",
        "onTap": () {},
      },
      {"icon": AppIcons.sellerContentQR, "label": "ПЕЧАТЬ QR", "onTap": () {}},
    ];

    // Разбиваем на ряды по 3 кнопки
    List<List<Map<String, dynamic>>> rows = [];
    for (int i = 0; i < actions.length; i += 3) {
      rows.add(
        actions.sublist(i, i + 3 > actions.length ? actions.length : i + 3),
      );
    }

    return Column(
      children: rows.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.paddingXs),
          child: SizedBox(
            height: height,
            child: Row(
              children: [
                for (int i = 0; i < row.length; i++) ...[
                  Expanded(
                    child: FilledButton(
                      onPressed: row[i]["onTap"],
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // общий радиус
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(row[i]["icon"], size: 18),
                          const SizedBox(height: 4),
                          Text(
                            row[i]["label"],
                            style: AppTextStyles.buttonActive.copyWith(
                              color: AppColors.white,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (i != row.length - 1) AppSpacing.horizontalSm,
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
