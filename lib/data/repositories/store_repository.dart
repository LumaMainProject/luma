import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/store.dart';

class StoresRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Одноразовое получение всех магазинов
  Future<List<Store>> getStores() async {
    final snapshot = await firestore.collection("stores").get();
    return snapshot.docs.map((doc) => Store.fromJson(doc.data(), doc.id)).toList();
  }

  /// Подписка на изменения в коллекции stores
  Stream<List<Store>> listenStores() {
    return firestore.collection("stores").snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return Store.fromJson(doc.data(), doc.id);
        }).toList();
      },
    );
  }

  /// Получить конкретный store
  Future<Store?> getStore(String id) async {
    final doc = await firestore.collection("stores").doc(id).get();
    if (!doc.exists) return null;
    return Store.fromJson(doc.data()!, doc.id);
  }

  /// Добавить новый store
  Future<void> addStore(Store store) async {
    await firestore.collection("stores").doc(store.id).set(store.toJson());
  }

  /// Обновить store
  Future<void> updateStore(Store store) async {
    await firestore.collection("stores").doc(store.id).update(store.toJson());
  }

  /// Удалить store
  Future<void> deleteStore(String id) async {
    await firestore.collection("stores").doc(id).delete();
  }
}
