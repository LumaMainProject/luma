import 'package:flutter/material.dart';
import 'package:luma/global/params/app_colors.dart';

class ColorSelectorGrid extends StatefulWidget {
  final List<Color> colors;
  final ValueChanged<Color> onColorSelected;

  const ColorSelectorGrid({
    super.key,
    required this.colors,
    required this.onColorSelected,
  });

  @override
  State<ColorSelectorGrid> createState() => _ColorSelectorGridState();
}

class _ColorSelectorGridState extends State<ColorSelectorGrid> {
  Color? _selected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 14,
        childAspectRatio: 1,
      ),
      itemCount: widget.colors.length,
      itemBuilder: (context, index) {
        final color = widget.colors[index];
        final isSelected = color == _selected;

        return Center(
          child: GestureDetector(
            onTap: () {
              setState(() => _selected = color);
              widget.onColorSelected(color);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.borderColor
                          : AppColors.inactiveBorderColor,
                      width: 1,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check,
                    size: 18,
                    color: _checkColorFor(
                      color,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _checkColorFor(Color bg) =>
      bg.computeLuminance() > 0.5 ? AppColors.iconColor : AppColors.whiteColor;
}
