import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  final String id;
  final String shopId;
  final String productId;
  final String videoUrl;
  final String description;
  final int views;
  final int likes;
  final int shares;
  final Timestamp createdAt;

  const Video({
    required this.id,
    required this.shopId,
    required this.productId,
    required this.videoUrl,
    required this.description,
    required this.views,
    required this.likes,
    required this.shares,
    required this.createdAt,
  });

  /// 👉 Фабрика для конвертации из Firestore
  factory Video.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Video(
      id: doc.id,
      shopId: data['shopId'] ?? '',
      productId: data['productId'] ?? '',
      videoUrl: data['videoUrl'] ?? '',
      description: data['description'] ?? '',
      views: data['views'] ?? 0,
      likes: data['likes'] ?? 0,
      shares: data['shares'] ?? 0,
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  /// 👉 Конвертация в Map для записи в Firestore
  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'productId': productId,
      'videoUrl': videoUrl,
      'description': description,
      'views': views,
      'likes': likes,
      'shares': shares,
      'createdAt': createdAt,
    };
  }

  /// 👉 Копия с изменёнными полями
  Video copyWith({
    String? shopId,
    String? productId,
    String? videoUrl,
    String? description,
    int? views,
    int? likes,
    int? shares,
    Timestamp? createdAt,
  }) {
    return Video(
      id: id,
      shopId: shopId ?? this.shopId,
      productId: productId ?? this.productId,
      videoUrl: videoUrl ?? this.videoUrl,
      description: description ?? this.description,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      shares: shares ?? this.shares,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
