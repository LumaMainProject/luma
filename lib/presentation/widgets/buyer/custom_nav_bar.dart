import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';

class CustomNavBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomNavBar({
    super.key,
    required this.icons,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: AppSizes.navBarHeight,
      margin: EdgeInsets.all(AppSpacing.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.borderColor, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSizes.buttonRadius),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSizes.buttonRadius),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingMd),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) {
            final isActive = selectedIndex == index;
            return GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: isActive ? 50 : 40,
                  height: isActive ? 50 : 40,
                  decoration: isActive
                      ? BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(
                            AppSizes.buttonRadius,
                          ),
                        )
                      : null,
                  alignment: Alignment.center,
                  child: Icon(
                    icons[index],
                    color: isActive ? Colors.white : AppColors.secondary,
                    size: 28,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
