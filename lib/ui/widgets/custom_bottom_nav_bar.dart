import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_icons.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: AppButtonStyle.customBottomNavBar,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(AppIcons.navBarHome, 0),
            _buildNavItem(AppIcons.navBarPlayer, 1),
            _buildNavItem(AppIcons.navBarCart, 2),
            _buildNavItem(AppIcons.navBarAccount, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = index == currentIndex;

    return !isSelected
        ? IconButton(
            onPressed: () => onTap(index),
            icon: Icon(icon, size: 20),
            style: AppButtonStyle.navBarIconButton,
          )
        : IconButton(
            onPressed: () => onTap(index),
            icon: Icon(icon, size: 20, color: AppColors.whiteColor),
            style: AppButtonStyle.navBarIconButtonActive,
          );
  }
}
