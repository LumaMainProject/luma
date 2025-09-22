import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luma_2/data/models/video.dart';

class VideoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = "videos";

  /// Добавить новое видео
  Future<void> addVideo(Video video) async {
    await _firestore.collection(_collection).add(video.toMap());
  }

  /// Получить последние видео (стрим для TikTok фида)
  Stream<List<Video>> getLatestVideos({int limit = 20}) {
    return _firestore
        .collection(_collection)
        .orderBy("createdAt", descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Video.fromFirestore(doc)).toList());
  }

  /// Получить видео по shopId
  Stream<List<Video>> getVideosByShop(String shopId) {
    return _firestore
        .collection(_collection)
        .where("shopId", isEqualTo: shopId)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Video.fromFirestore(doc)).toList());
  }

  /// Увеличить счётчик просмотров
  Future<void> incrementViews(String videoId) async {
    await _firestore.collection(_collection).doc(videoId).update({
      "views": FieldValue.increment(1),
    });
  }

  /// Увеличить счётчик лайков
  Future<void> incrementLikes(String videoId) async {
    await _firestore.collection(_collection).doc(videoId).update({
      "likes": FieldValue.increment(1),
    });
  }

  /// Увеличить счётчик репостов/шаров
  Future<void> incrementShares(String videoId) async {
    await _firestore.collection(_collection).doc(videoId).update({
      "shares": FieldValue.increment(1),
    });
  }

  /// Удалить видео
  Future<void> deleteVideo(String videoId) async {
    await _firestore.collection(_collection).doc(videoId).delete();
  }
}
