import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luma_2/data/models/app_notifications.dart';
import 'package:luma_2/data/repositories/notifications_repository.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsRepository notificationsRepository;
  StreamSubscription<List<AppNotification>>? _notificationsSub;

  NotificationsBloc(this.notificationsRepository)
    : super(NotificationsInitial()) {
    // Загрузка уведомлений
    on<LoadNotifications>((event, emit) async {
      emit(NotificationsLoading());
      await _notificationsSub?.cancel();
      _notificationsSub = notificationsRepository
          .streamUserNotifications(event.userId)
          .listen(
            (notifications) => add(SetNotifications(notifications)),
            onError: (error) => add(NotificationsErrorEvent(error.toString())),
          );
    });

    // Установка уведомлений
    on<SetNotifications>(
      (event, emit) => emit(NotificationsLoaded(event.notifications)),
    );

    // Очистка
    on<ClearNotifications>((event, emit) async {
      await _notificationsSub?.cancel();
      emit(NotificationsInitial());
    });

    // Пометить как прочитанное
    on<MarkAsRead>((event, emit) async {
      if (state is NotificationsLoaded) {
        final current = (state as NotificationsLoaded).notifications;
        final updated = current.map((n) {
          if (n.id == event.notification.id) {
            return n.copyWith(isRead: true);
          }
          return n;
        }).toList();

        emit(NotificationsLoaded(updated));

        try {
          await notificationsRepository.markAsRead(event.notification);
        } catch (_) {
          emit(NotificationsLoaded(current)); // откат
        }
      }
    });

    // Ошибка
    on<NotificationsErrorEvent>(
      (event, emit) => emit(NotificationsError(event.message)),
    );
  }

  @override
  Future<void> close() async {
    await _notificationsSub?.cancel();
    return super.close();
  }
}
