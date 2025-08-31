part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object?> get props => [];
}

class LoadUserChats extends ChatEvent {
  final String userId;
  const LoadUserChats(this.userId);
  @override
  List<Object?> get props => [userId];
}

class SetChats extends ChatEvent {
  final List<Chat> chats;
  const SetChats(this.chats);
  @override
  List<Object?> get props => [chats];
}

class LoadMessages extends ChatEvent {
  final String chatId;
  const LoadMessages(this.chatId);
  @override
  List<Object?> get props => [chatId];
}

class SetMessages extends ChatEvent {
  final String chatId;
  final List<Message> messages;
  const SetMessages({required this.chatId, required this.messages});
  @override
  List<Object?> get props => [chatId, messages];
}

class SendMessage extends ChatEvent {
  final String chatId;
  final Message message;
  const SendMessage({required this.chatId, required this.message});
  @override
  List<Object?> get props => [chatId, message];
}

class ChatErrorEvent extends ChatEvent {
  final String message;
  const ChatErrorEvent(this.message);
  @override
  List<Object?> get props => [message];
}

class ClearUserChats extends ChatEvent {}

