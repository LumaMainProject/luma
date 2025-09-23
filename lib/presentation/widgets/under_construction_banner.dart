import 'package:flutter/material.dart';

class UnderConstructionBanner extends StatelessWidget {
  const UnderConstructionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: -0.1, // наклон в радианах (≈ -6 градусов)
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(0),
          ),
          child: const Text(
            "UNDER CONSTRUCTION",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
