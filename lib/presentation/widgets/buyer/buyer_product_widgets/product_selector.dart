import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';

class ProductSelector extends StatefulWidget {
  const ProductSelector({super.key});

  @override
  State<ProductSelector> createState() => _ProductSelectorState();
}

class _ProductSelectorState extends State<ProductSelector> {
  int? selectedIndex;

  // Заглушка цветов (тут можно потом подменить на реальные)
  final List<Color?> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    null, // отсутствующий цвет
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Цвет", style: AppTextStyles.buttonDeactive),
          SizedBox(height: AppSpacing.paddingSm),
          Wrap(
            spacing: 12,
            children: List.generate(colors.length, (index) {
              final color = colors[index];
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  if (color != null) {
                    setState(() {
                      selectedIndex = index;
                    });
                  }
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color ?? Colors.transparent,
                    border: Border.all(color: AppColors.borderColor, width: 2),
                  ),
                  child: Center(
                    child: color == null
                        ? Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.red,
                          ) // отсутствующий
                        : isSelected
                        ? const Icon(
                            Icons.check,
                            size: 20,
                            color: Colors.white,
                          ) // выбранный
                        : null,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: AppSpacing.paddingMd),
        ],
      ),
    );
  }
}
