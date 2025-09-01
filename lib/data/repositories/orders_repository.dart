import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luma_2/data/models/user_profile.dart';

class OrdersRepository {
  final FirebaseFirestore _firestore;

  OrdersRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  // Возвращаем поток только заказов текущего пользователя
  Stream<List<CurrentOrder>> getOrdersByUser(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CurrentOrder.fromJson(doc.data()))
              .toList(),
        );
  }

  // Получаем поток заказов по конкретному магазину
  Stream<List<CurrentOrder>> getOrdersByStore(String storeId) {
    return _firestore
        .collection('orders')
        .where('storeId', isEqualTo: storeId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CurrentOrder.fromJson(doc.data()))
              .toList(),
        );
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) {
    return _firestore.collection('orders').doc(orderId).update({
      'status': newStatus,
    });
  }
}
