import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String id;
  final List<String> participants;
  final Map<String, String> participantAvatars;
  final String lastMessage;
  final DateTime lastUpdated;

  // Новый: время последнего прочтения каждого пользователя
  final Map<String, DateTime> lastReadAt;

  Chat({
    required this.id,
    required this.participants,
    required this.participantAvatars,
    required this.lastMessage,
    required this.lastUpdated,
    required this.lastReadAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json, String id) {
    final lastReadMap = (json['lastReadAt'] as Map<String, dynamic>?) ?? {};
    final lastReadAt = lastReadMap.map(
      (key, value) => MapEntry(key, (value as Timestamp).toDate()),
    );

    return Chat(
      id: id,
      participants: List<String>.from(json['participants']),
      participantAvatars: Map<String, String>.from(
        json['participantAvatars'] ?? {},
      ),
      lastMessage: json['lastMessage'] ?? '',
      lastUpdated: (json['lastUpdated'] as Timestamp).toDate(),
      lastReadAt: lastReadAt,
    );
  }

  Map<String, dynamic> toJson() => {
    "participants": participants,
    "participantAvatars": participantAvatars,
    "lastMessage": lastMessage,
    "lastUpdated": lastUpdated,
    "lastReadAt": lastReadAt.map((k, v) => MapEntry(k, v)),
  };

  /// Проверка: есть ли непрочитанные сообщения для пользователя
  bool hasUnreadMessages(String userId) {
    final readAt = lastReadAt[userId];
    if (readAt == null) return true; // никогда не читал — есть новые
    return lastUpdated.isAfter(readAt);
  }
}
