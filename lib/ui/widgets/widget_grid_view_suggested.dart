import 'package:flutter/material.dart';
import 'package:luma/ui/widgets/widget_item_card.dart';

class WidgetGridViewSuggested extends StatelessWidget {
  const WidgetGridViewSuggested({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: .8,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) => WidgetItemCard(),
      itemCount: 10,
    );
  }
}