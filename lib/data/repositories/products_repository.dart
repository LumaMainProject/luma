import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductsRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Получение всех продуктов (один раз)
  Future<List<Product>> getProducts() async {
    final snapshot = await firestore.collection("products").get();
    return snapshot.docs
        .map((doc) => Product.fromJson(doc.data(), doc.id))
        .toList();
  }

  /// Получение продукта по id
  Future<Product?> getProduct(String id) async {
    final doc = await firestore.collection("products").doc(id).get();
    if (!doc.exists) return null;
    return Product.fromJson(doc.data()!, doc.id);
  }

  /// Добавление продукта
  Future<void> addProduct(Product product) async {
    await firestore
        .collection("products")
        .doc(product.id)
        .set(product.toJson());
  }

  /// Обновление продукта
  Future<void> updateProduct(Product product) async {
    await firestore
        .collection("products")
        .doc(product.id)
        .update(product.toJson());
  }

  /// Удаление продукта
  Future<void> deleteProduct(String id) async {
    await firestore.collection("products").doc(id).delete();
  }

  /// 🔥 Реактивный стрим продуктов (для Cubit)
  Stream<List<Product>> listenProducts() {
    return firestore.collection("products").snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => Product.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }
}
