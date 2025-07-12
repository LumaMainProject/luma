import 'package:flutter/material.dart';
import 'package:luma/global/app_text_styles.dart';
import 'package:luma/ui/widgets/widget_shop_cart_item.dart';

class PageBuyerHomepageCart extends StatelessWidget {
  const PageBuyerHomepageCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
          itemBuilder: (context, index) {
            return WidgetShopCartItem();
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: 10,
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 50,
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                  ),
                ),
                child: Text("Buy", style: AppTextStyles.title,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
