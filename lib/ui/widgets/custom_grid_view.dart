import 'package:flutter/material.dart';

class CustimGridView extends StatelessWidget {
  final double itemHeight;
  final double itemWidth;
  final double multiplier;
  final Widget? Function(BuildContext, int) itemBuilder;
  const CustimGridView({
    super.key,
    this.itemHeight = 82,
    this.itemWidth = 50,
    this.multiplier = 1,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(14),

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 14,
        childAspectRatio: (itemHeight * multiplier) / (itemWidth * multiplier),
      ),
      itemBuilder: itemBuilder,
      itemCount: 10,
    );
  }
}
