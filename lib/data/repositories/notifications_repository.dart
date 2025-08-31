import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luma_2/data/models/app_notifications.dart';

class NotificationsRepository {
  final FirebaseFirestore firestore;

  NotificationsRepository({FirebaseFirestore? firestore})
    : firestore = firestore ?? FirebaseFirestore.instance;

  /// Стрим всех уведомлений пользователя
  Stream<List<AppNotification>> streamUserNotifications(String userId) {
    return firestore
        .collection("users")
        .doc(userId)
        .collection("notifications")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map(
                (doc) => AppNotification.fromJson(
                  doc.data(),
                  doc.id,
                  userId: userId, // ← важное добавление
                ),
              )
              .toList(),
        );
  }

  /// Добавить уведомление
  Future<void> addNotification(AppNotification notification) async {
    await firestore
        .collection("users")
        .doc(notification.userId) // берём userId из модели
        .collection("notifications")
        .add(notification.toJson());
  }

  /// Пометить уведомление как прочитанное
  Future<void> markAsRead(AppNotification notification) async {
    await firestore
        .collection("users")
        .doc(notification.userId)
        .collection("notifications")
        .doc(notification.id)
        .update({"isRead": true});
  }
}
