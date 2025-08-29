import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/review.dart';
import 'package:shimmer/shimmer.dart';

class SingleReview extends StatefulWidget {
  final Review review;

  const SingleReview({super.key, required this.review});

  @override
  State<SingleReview> createState() => _SingleReviewState();
}

class _SingleReviewState extends State<SingleReview> {
  String? avatarUrl;
  static final Map<String, String?> _avatarCache = {}; // userId → avatarUrl

  @override
  void initState() {
    super.initState();
    _loadAvatar();
  }

  Future<void> _loadAvatar() async {
    final userId = widget.review.userId;

    // Проверяем кэш
    if (_avatarCache.containsKey(userId)) {
      setState(() {
        avatarUrl = _avatarCache[userId];
      });
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      final url = doc.data()?['avatarUrl'] as String?;
      _avatarCache[userId] = url;

      setState(() {
        avatarUrl = url;
      });
    } catch (_) {
      // если ошибка, оставляем null
      _avatarCache[userId] = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'd MMM',
      'ru',
    ).format(widget.review.createdAt.toDate());

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        color: AppColors.white,
        border: Border.all(color: AppColors.borderColor),
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Аватарка пользователя
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: avatarUrl != null
                      ? CachedNetworkImage(
                          imageUrl: avatarUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(color: Colors.white),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.person, size: 35),
                        )
                      : const Icon(Icons.person, size: 35),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.review.userName,
                      style: AppTextStyles.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          AppIcons.raiting,
                          size: 10,
                          color: index < widget.review.rating
                              ? AppColors.primary
                              : AppColors.borderColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(formattedDate, style: AppTextStyles.text),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.review.text,
            style: AppTextStyles.text,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
