import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luma_2/data/models/chat.dart';
import 'package:luma_2/data/models/message.dart';
import 'package:luma_2/data/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repository;
  StreamSubscription<List<Chat>>? _chatsSub;
  final Map<String, StreamSubscription<List<Message>>> _messagesSubs = {};

  ChatBloc(this.repository) : super(ChatInitial()) {
    on<LoadUserChats>((event, emit) async {
      emit(ChatLoading());
      await _chatsSub?.cancel();
      _chatsSub = repository
          .streamUserChats(event.userId)
          .listen(
            (chats) {
              add(SetChats(chats));
            },
            onError: (error) {
              add(ChatErrorEvent(error.toString()));
            },
          );
    });

    on<SetChats>((event, emit) {
      emit(ChatLoaded(chats: event.chats, messages: {}));
    });

    on<LoadMessages>((event, emit) async {
      _messagesSubs[event.chatId]?.cancel();
      _messagesSubs[event.chatId] = repository
          .streamMessages(event.chatId)
          .listen(
            (messages) {
              add(SetMessages(chatId: event.chatId, messages: messages));
            },
            onError: (error) {
              add(ChatErrorEvent(error.toString()));
            },
          );
    });

    on<SetMessages>((event, emit) {
      if (state is ChatLoaded) {
        final current = state as ChatLoaded;
        final updatedMessages = Map<String, List<Message>>.from(
          current.messages,
        );
        updatedMessages[event.chatId] = event.messages;
        emit(current.copyWith(messages: updatedMessages));
      }
    });

    on<SendMessage>((event, emit) async {
      try {
        await repository.sendMessage(event.chatId, event.message);
      } catch (_) {}
    });

    on<ClearUserChats>((event, emit) {
      for (var sub in _messagesSubs.values) {
        sub.cancel();
      }
      _messagesSubs.clear();
      _chatsSub?.cancel();
      emit(ChatLoaded(chats: [], messages: {}));
    });

    on<ChatErrorEvent>((event, emit) {
      emit(ChatError(event.message));
    });
  }

  @override
  Future<void> close() async {
    await _chatsSub?.cancel();
    for (var sub in _messagesSubs.values) {
      await sub.cancel();
    }
    return super.close();
  }
}
