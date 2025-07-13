import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:luma/global/app_text_styles.dart';

class PageSellerProfile extends StatelessWidget {
  const PageSellerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.transparent),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Container(width: 120, height: 120, color: Colors.amber),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Name", style: AppTextStyles.title),
                      Text("Gender", style: AppTextStyles.title2),
                      Text("Birthdate", style: AppTextStyles.title2),
                    ],
                  ),
                ],
              ),
            ),

            const SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text("Sizes", style: AppTextStyles.title2),
                  SizedBox(height: 16),
                  Placeholder(),
                ],
              ),
            ),

            const SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text("Interests", style: AppTextStyles.title2),
                  SizedBox(height: 16),
                  Placeholder(),
                ],
              ),
            ),

            const SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text("Following", style: AppTextStyles.title2),
                  SizedBox(height: 16),
                  Placeholder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
