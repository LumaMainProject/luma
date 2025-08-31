import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  final String id;
  final String userId;
  final String title;
  final String body;
  final String type; // order, delivery, promo, etc.
  final bool isRead;
  final DateTime createdAt;
  final String? imageUrl; // ← ссылка на товар
  final String? actionLabel; // ← текст кнопки ("Посмотреть", "Открыть", и т.п.)

  AppNotification({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.imageUrl,
    this.actionLabel,
  });

  /// userId сюда передаём снаружи (из пути users/{userId}/notifications)
  factory AppNotification.fromJson(
    Map<String, dynamic> json,
    String id, {
    required String userId,
  }) {
    return AppNotification(
      id: id,
      userId: userId,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      type: json['type'] ?? 'general',
      isRead: json['isRead'] ?? false,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      imageUrl: json['imageUrl'], // 🚀
      actionLabel: json['actionLabel'], // 🚀
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "type": type,
      "isRead": isRead,
      "createdAt": createdAt,
      "imageUrl": imageUrl, // 🚀 сохраняем
      "actionLabel": actionLabel, // 🚀 сохраняем
      // userId в сабколлекции хранить не обязательно, поэтому не пишем
    };
  }

  AppNotification copyWith({
    String? id,
    String? userId,
    String? title,
    String? body,
    String? type,
    bool? isRead,
    DateTime? createdAt,
    String? imageUrl,
    String? actionLabel,
  }) {
    return AppNotification(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
      actionLabel: actionLabel ?? this.actionLabel,
    );
  }
}
