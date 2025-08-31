import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/router/app_routes.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/logic/bloc/chat_bloc.dart';
import 'package:luma_2/logic/user/user_bloc.dart';
import 'package:shimmer/shimmer.dart';

class BuyerHomepageScreenAccount extends StatelessWidget {
  const BuyerHomepageScreenAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return BlocBuilder<ChatBloc, ChatState>(
          builder: (context, chatState) {
            if (chatState is! ChatLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            final List<_ProfileItem> topItems = [
              _ProfileItem(
                title: "Мои заказы",
                description: "${state.user.inTrackOrders.length} заказов",
                icon: AppIcons.shop,
                route: AppRoute.buyerAccountOrders,
              ),
              _ProfileItem(
                title: "Избранное",
                description: "${state.user.favoriteProducts.length} товаров",
                icon: AppIcons.favorite,
                route: AppRoute.buyerAccountFavorite,
              ),
              _ProfileItem(
                title: "Сообщения",
                description: "${chatState.chats.length} новых",
                icon: AppIcons.message,
                route: AppRoute.buyerAccountMessenger,
              ),
            ];

            final List<_ProfileItem> settingsItems = [
              _ProfileItem(
                title: "Уведомления",
                description: "Настройка push-уведомлений",
                icon: AppIcons.notification,
              ),
              _ProfileItem(
                title: "Способы оплаты",
                description: "2 карты привязано",
                icon: AppIcons.card,
              ),
              _ProfileItem(
                title: "Адреса доставки",
                description: "Дом, Работа",
                icon: AppIcons.gps,
              ),
              _ProfileItem(
                title: "Безопасность",
                description: "Пароль, двухфакторная аутентификация",
                icon: AppIcons.security,
              ),
              _ProfileItem(
                title: "Помощь и поддержка",
                description: "FAQ, связаться с нами",
                icon: AppIcons.navBarHome,
              ),
            ];

            return Scaffold(
              appBar: AppBar(
                title: Text("Профиль"),
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: _ProfileHeader(
                    avatarUrl: state.user.avatarUrl,
                    name: state.user.name,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Верхние кнопки
                    ...topItems.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: OutlinedButton.icon(
                          icon: _IconWithBg(
                            icon: item.icon,
                            color: AppColors.primary,
                          ),
                          label: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title, style: AppTextStyles.headline),
                              Text(item.description, style: AppTextStyles.text),
                            ],
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            side: BorderSide(color: AppColors.borderColor),
                            minimumSize: const Size.fromHeight(60),
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            if (item.route != null) {
                              context.pushNamed(item.route!.name);
                            }
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),
                    const Divider(),
                    const SizedBox(height: 22),

                    const Text("Настройки", style: AppTextStyles.headline),
                    const SizedBox(height: 10),

                    ListView.separated(
                      itemBuilder: (context, index) {
                        final item = settingsItems[index];
                        return OutlinedButton.icon(
                          icon: _IconWithBg(
                            icon: item.icon,
                            color: AppColors.primary,
                          ),
                          label: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title, style: AppTextStyles.headline),
                              Text(item.description, style: AppTextStyles.text),
                            ],
                          ),
                          onPressed: () {
                            // 🚧 пока заглушки
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Открыть: ${item.title}")),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            side: BorderSide(color: AppColors.borderColor),
                            minimumSize: const Size.fromHeight(60),
                            alignment: Alignment.centerLeft,
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemCount: settingsItems.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String? avatarUrl;
  final String name;

  const _ProfileHeader({required this.avatarUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
            child: SizedBox(
              width: AppSizes.avatarMd,
              height: AppSizes.avatarMd,
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
                          const Icon(Icons.person, size: AppSizes.avatarMd),
                    )
                  : const Icon(Icons.person, size: AppSizes.avatarMd),
            ),
          ),
          const SizedBox(width: 12),
          Text(name, style: AppTextStyles.text),
          const Spacer(),
          IconButton(
            onPressed: () {
              context.pushNamed(AppRoute.buyerAccountEdit.name);
            },
            icon: const Icon(AppIcons.edit, color: AppColors.text),
          ),
        ],
      ),
    );
  }
}

class _ProfileItem {
  final String title;
  final String description;
  final IconData icon;
  final AppRoute? route;

  const _ProfileItem({
    required this.title,
    required this.description,
    required this.icon,
    this.route,
  });
}

// 👇 общий виджет для иконки с фоном
class _IconWithBg extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _IconWithBg({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withAlpha(90), // фон с прозрачностью
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
