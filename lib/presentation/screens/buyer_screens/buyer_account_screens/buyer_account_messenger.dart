import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/logic/chat/chat_bloc.dart';
import 'package:luma_2/logic/user/user_bloc.dart';
import 'package:luma_2/presentation/widgets/buyer/messenger_widget.dart';

class BuyerAccountMessenger extends StatelessWidget {
  const BuyerAccountMessenger({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Сообщения")),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is! UserLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final String currentUserId = userState.user.id;

          return BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ChatLoaded) {
                final chats = state.chats;

                if (chats.isEmpty) {
                  return const Center(child: Text("Нет сообщений"));
                }

                return ListView.separated(
                  itemCount: chats.length,
                  padding: const EdgeInsets.all(AppSpacing.paddingMd),
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.paddingMd),
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return MessengerWidget(
                      chat: chat,
                      currentUserId: currentUserId,
                    );
                  },
                );
              } else if (state is ChatError) {
                return Center(child: Text("Ошибка: ${state.message}"));
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }
}
