import 'package:flutter/material.dart';

class WidgetItemCard extends StatelessWidget {
  const WidgetItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(16),
            ),
          ),
          onPressed: () {},
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadiusDirectional.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text("Name"),
              Text("Price"),
              SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
