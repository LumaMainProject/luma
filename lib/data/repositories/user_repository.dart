import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luma_2/data/models/user_profile.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔹 Получение пользователя один раз
  Future<UserProfile?> getUserProfile(String uid) async {
    final doc = await _firestore.collection("users").doc(uid).get();
    if (!doc.exists) return null;
    return UserProfile.fromJson(doc.data()!, doc.id);
  }

  // 🔹 Поток изменений пользователя
  Stream<UserProfile> streamUserProfile(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((snapshot) => UserProfile.fromJson(snapshot.data()!, snapshot.id));
  }

  // 🔹 Обновление профиля
  Future<void> updateUserProfile(UserProfile profile) async {
    await _firestore
        .collection("users")
        .doc(profile.id)
        .set(profile.toJson(), SetOptions(merge: true));
  }

  // 🔹 Добавление продукта в избранное
  Future<void> addProductToFavorites(String uid, String productId) async {
    final userRef = _firestore.collection("users").doc(uid);
    final productRef = _firestore.collection("products").doc(productId);

    await _firestore.runTransaction((tx) async {
      final userSnapshot = await tx.get(userRef);
      final productSnapshot = await tx.get(productRef);
      if (!userSnapshot.exists || !productSnapshot.exists) return;

      final favorites = List<String>.from(userSnapshot['favoriteProducts'] ?? []);
      if (!favorites.contains(productId)) {
        favorites.add(productId);
        tx.update(userRef, {'favoriteProducts': favorites});
        tx.update(productRef, {
          'favoritesCount': (productSnapshot['favoritesCount'] ?? 0) + 1,
        });
      }
    });
  }

  // 🔹 Удаление продукта из избранного
  Future<void> removeProductFromFavorites(String uid, String productId) async {
    final userRef = _firestore.collection("users").doc(uid);
    final productRef = _firestore.collection("products").doc(productId);

    await _firestore.runTransaction((tx) async {
      final userSnapshot = await tx.get(userRef);
      final productSnapshot = await tx.get(productRef);
      if (!userSnapshot.exists || !productSnapshot.exists) return;

      final favorites = List<String>.from(userSnapshot['favoriteProducts'] ?? []);
      if (favorites.contains(productId)) {
        favorites.remove(productId);
        tx.update(userRef, {'favoriteProducts': favorites});

        final currentCount = productSnapshot['favoritesCount'] ?? 0;
        tx.update(productRef, {
          'favoritesCount': currentCount > 0 ? currentCount - 1 : 0,
        });
      }
    });
  }
}
