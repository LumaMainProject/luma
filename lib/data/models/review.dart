import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// --- REVIEW MODEL ---
class Review extends Equatable {
  final String userId;
  final String userName;
  final String text;
  final int rating; // 1–5
  final Timestamp createdAt;

  const Review({
    required this.userId,
    required this.userName,
    required this.text,
    required this.rating,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? 'Аноним',
      text: json['text'] ?? '',
      rating: json['rating'] ?? 0,
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userName": userName,
      "text": text,
      "rating": rating,
      "createdAt": createdAt,
    };
  }

  @override
  List<Object?> get props => [userId, userName, text, rating, createdAt];
}
