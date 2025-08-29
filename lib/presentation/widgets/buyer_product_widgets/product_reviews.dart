import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/data/models/review.dart';
import 'single_review.dart';

class ProductReviews extends StatelessWidget {
  final List<Review>? reviews;

  const ProductReviews({super.key, this.reviews});

  @override
  Widget build(BuildContext context) {
    final items = reviews ?? [];

    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingMd),
        child: const Text("Пока нет отзывов"),
      );
    }

    return SizedBox(
      height: 150, // можно подогнать под SingleReview
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingMd),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final review = items[index];
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.paddingMd),
            child: SizedBox(
              width: 250, // ширина карточки
              child: SingleReview(review: review),
            ),
          );
        },
      ),
    );
  }
}
