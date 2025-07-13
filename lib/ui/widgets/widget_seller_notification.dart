import 'package:flutter/material.dart';
import 'package:luma/global/params/app_text_styles.dart';

class WidgetSellerNotification extends StatelessWidget {
  const WidgetSellerNotification({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Store Name", style: AppTextStyles.title2),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: BoxBorder.all(),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 80, height: 80, color: Colors.amber),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Text", style: AppTextStyles.description),
                      Text("Text", style: AppTextStyles.description),
                      Text("Text", style: AppTextStyles.description),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Price", style: AppTextStyles.title2),
                      Row(
                        children: [
                          IconButton.outlined(
                            onPressed: () {},
                            icon: Icon(Icons.call_outlined),
                          ),
                          IconButton.outlined(
                            onPressed: () {},
                            icon: Icon(Icons.sms_outlined),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.all(20)),
                      child: const Text("Refuse", style: AppTextStyles.title2),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.all(20)),
                      child: const Text("Confirm", style: AppTextStyles.title2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}