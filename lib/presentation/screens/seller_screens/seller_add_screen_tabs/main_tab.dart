import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  bool isPhotoSelected = true; // по умолчанию выбрано "Добавить фото"

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Column(
        children: [
          // --- Сетка 3x2 ---
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // обработка нажатия
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Center(
                    child: index == 0
                        ? const Icon(
                            Icons.image,
                            size: 28,
                            color: AppColors.text,
                          )
                        : const Icon(
                            Icons.add,
                            size: 28,
                            color: AppColors.text,
                          ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
    
          // --- Кнопки-селекторы ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSelectorButton(
                title: "Добавить фото",
                isSelected: isPhotoSelected,
                onTap: () {
                  setState(() {
                    isPhotoSelected = true;
                  });
                },
              ),
              const SizedBox(width: 12),
              _buildSelectorButton(
                title: "Добавить видео",
                isSelected: !isPhotoSelected,
                onTap: () {
                  setState(() {
                    isPhotoSelected = false;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectorButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.background,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.text,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
