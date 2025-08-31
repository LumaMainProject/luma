part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotifications extends NotificationsEvent {
  final String userId;
  const LoadNotifications(this.userId);

  @override
  List<Object?> get props => [userId];
}

class SetNotifications extends NotificationsEvent {
  final List<AppNotification> notifications;
  const SetNotifications(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class ClearNotifications extends NotificationsEvent {}

class MarkAsRead extends NotificationsEvent {
  final AppNotification notification;
  const MarkAsRead(this.notification);

  @override
  List<Object?> get props => [notification];
}

class NotificationsErrorEvent extends NotificationsEvent {
  final String message;
  const NotificationsErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}
