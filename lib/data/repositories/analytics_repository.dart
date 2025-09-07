import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luma_2/data/models/user_profile.dart';

class AnalyticsRepository {
  final FirebaseFirestore _firestore;

  AnalyticsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Количество заказов сегодня у конкретного магазина
  Future<int> getTodayOrdersCount(String storeId) async {
    final todayStart =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final todayEnd = todayStart.add(Duration(days: 1));

    final snapshot = await _firestore
        .collection('orders')
        .where('storeId', isEqualTo: storeId)
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
        .where('createdAt', isLessThan: Timestamp.fromDate(todayEnd))
        .get();

    return snapshot.docs.length;
  }

  /// Общая статистика по магазину
  Future<Map<String, dynamic>> getStoreAnalytics(String storeId) async {
    // Получаем все заказы магазина
    final ordersSnapshot = await _firestore
        .collection('orders')
        .where('storeId', isEqualTo: storeId)
        .get();

    final orders = ordersSnapshot.docs.map((doc) => CurrentOrder.fromJson(doc.data())).toList();

    // Подсчет ключевых метрик
    int totalOrders = orders.length;
    double totalRevenue = orders.fold(0.0, (sum, o) => sum + o.totalPrice);
    int deliveredOrders = orders.where((o) => o.status == 'delivered').length;
    int pendingOrders = orders.where((o) => o.status == 'pending').length;

    return {
      "totalOrders": totalOrders,
      "totalRevenue": totalRevenue,
      "deliveredOrders": deliveredOrders,
      "pendingOrders": pendingOrders,
    };
  }

  /// Статистика по конкретному продукту
  Future<Map<String, dynamic>> getProductAnalytics(String productId) async {
    final snapshot = await _firestore
        .collection('orders')
        .where('productId', isEqualTo: productId)
        .get();

    final orders = snapshot.docs.map((doc) => CurrentOrder.fromJson(doc.data())).toList();

    int totalSold = orders.fold(0, (sum, o) => sum + o.quantity);
    double totalRevenue = orders.fold(0.0, (sum, o) => sum + o.totalPrice);

    return {
      "totalSold": totalSold,
      "totalRevenue": totalRevenue,
      "ordersCount": orders.length,
    };
  }

  /// Топ N продуктов по продажам у магазина
  Future<List<String>> getTopProducts(String storeId, {int topN = 5}) async {
    final snapshot = await _firestore
        .collection('orders')
        .where('storeId', isEqualTo: storeId)
        .get();

    final orders = snapshot.docs.map((doc) => CurrentOrder.fromJson(doc.data())).toList();

    // Группировка по productId
    final Map<String, int> productCounts = {};
    for (var o in orders) {
      productCounts[o.productId] = (productCounts[o.productId] ?? 0) + o.quantity;
    }

    // Сортировка и выбор топ N
    final sorted = productCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sorted.take(topN).map((e) => e.key).toList();
  }
}
