part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Chat> chats;
  final Map<String, List<Message>> messages; // chatId → messages

  const ChatLoaded({this.chats = const [], this.messages = const {}});

  ChatLoaded copyWith({
    List<Chat>? chats,
    Map<String, List<Message>>? messages,
  }) {
    return ChatLoaded(
      chats: chats ?? this.chats,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [chats, messages];
}

class ChatError extends ChatState {
  final String message;
  const ChatError(this.message);
  @override
  List<Object?> get props => [message];
}
