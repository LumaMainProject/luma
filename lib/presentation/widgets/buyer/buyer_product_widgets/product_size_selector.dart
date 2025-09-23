import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';

class ProductSizeSelector extends StatefulWidget {
  const ProductSizeSelector({super.key});

  @override
  State<ProductSizeSelector> createState() => _ProductSizeSelectorState();
}

class _ProductSizeSelectorState extends State<ProductSizeSelector> {
  // Заглушка: размеры одежды
  final List<String> sizes = ["XS", "S", "M", "L", "XL", "XXL"];

  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.paddingMd),
          Text("Размер", style: AppTextStyles.buttonDeactive),
          SizedBox(height: AppSpacing.paddingSm),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "Выбрать размер",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            initialValue: selectedSize,
            items: sizes
                .map(
                  (size) =>
                      DropdownMenuItem<String>(value: size, child: Text(size)),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedSize = value;
              });
            },
          ),
          SizedBox(height: AppSpacing.paddingMd),
        ],
      ),
    );
  }
}
