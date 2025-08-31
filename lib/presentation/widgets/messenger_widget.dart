import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/chat.dart';

class MessengerWidget extends StatelessWidget {
  final Chat chat;
  final String currentUserId; // id текущего пользователя

  const MessengerWidget({
    super.key,
    required this.chat,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    // находим участника, который не текущий
    final otherParticipantId = chat.participants.firstWhere(
      (id) => id != currentUserId,
      orElse: () => currentUserId, // fallback, если чат с самим собой
    );

    final avatarUrl = chat.participantAvatars[otherParticipantId] ?? '';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: Row(
          children: [
            // Аватар
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              child: CachedNetworkImage(
                imageUrl: avatarUrl,
                width: AppSizes.avatarLg,
                height: AppSizes.avatarLg,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: AppSizes.avatarLg,
                  height: AppSizes.avatarLg,
                  color: Colors.grey.shade200,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),

            const SizedBox(width: 12),

            // Текстовая часть
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Первая строка: lastMessage + время + индикатор новых сообщений
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          style: AppTextStyles.buttonDeactive,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat.Hm().format(chat.lastUpdated),
                        style: AppTextStyles.textButton,
                      ),
                      if (chat.hasUnreadMessages(currentUserId))
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Вторая строка: полное сообщение или превью
                  Text(
                    chat.lastMessage,
                    style: AppTextStyles.text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
