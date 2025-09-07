import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/data/models/revenue_point.dart';
import 'package:luma_2/data/models/user_profile.dart';
import 'package:luma_2/data/repositories/orders_repository.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final OrdersRepository ordersRepository;
  StreamSubscription? _ordersSubscription;

  AnalyticsBloc({required this.ordersRepository}) : super(AnalyticsInitial()) {
    on<LoadStoreAnalytics>(_onLoadStoreAnalytics);
    on<OrdersUpdated>(_onOrdersUpdated);
  }

  void _onLoadStoreAnalytics(
    LoadStoreAnalytics event,
    Emitter<AnalyticsState> emit,
  ) {
    _ordersSubscription?.cancel();
    _ordersSubscription = ordersRepository
        .getOrdersByStore(event.storeId)
        .listen((orders) {
          add(OrdersUpdated(orders: orders));
        });
  }

  void _onOrdersUpdated(OrdersUpdated event, Emitter<AnalyticsState> emit) {
    final now = DateTime.now();

    // ====== Заказы за сегодня ======
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final todayOrdersList = event.orders
        .where(
          (o) =>
              o.createdAt.toDate().isAfter(todayStart) &&
              o.createdAt.toDate().isBefore(todayEnd),
        )
        .toList();

    // ====== Выручка за текущий месяц ======
    final monthStart = DateTime(now.year, now.month, 1);
    final nextMonthStart = (now.month < 12)
        ? DateTime(now.year, now.month + 1, 1)
        : DateTime(now.year + 1, 1, 1);

    final monthOrdersList = event.orders
        .where(
          (o) =>
              o.createdAt.toDate().isAfter(monthStart) &&
              o.createdAt.toDate().isBefore(nextMonthStart),
        )
        .toList();

    final monthRevenue = monthOrdersList.fold(
      0.0,
      (sum, o) => sum + o.totalPrice,
    );

    // ====== Выручка за прошлый месяц для процента ======
    final prevMonthStart = (now.month > 1)
        ? DateTime(now.year, now.month - 1, 1)
        : DateTime(now.year - 1, 12, 1);
    final prevMonthEnd = monthStart;

    final prevMonthOrdersList = event.orders
        .where(
          (o) =>
              o.createdAt.toDate().isAfter(prevMonthStart) &&
              o.createdAt.toDate().isBefore(prevMonthEnd),
        )
        .toList();

    final prevMonthRevenue = prevMonthOrdersList.fold(
      0.0,
      (sum, o) => sum + o.totalPrice,
    );

    // ====== Рост / падение заказов (сравниваем сегодня с вчера) ======
    final yesterdayStart = todayStart.subtract(const Duration(days: 1));
    final yesterdayEnd = todayStart;

    final yesterdayOrdersList = event.orders
        .where(
          (o) =>
              o.createdAt.toDate().isAfter(yesterdayStart) &&
              o.createdAt.toDate().isBefore(yesterdayEnd),
        )
        .toList();

    double ordersGrowth;
    if (yesterdayOrdersList.isEmpty) {
      ordersGrowth = todayOrdersList.isEmpty
          ? 0.0
          : todayOrdersList.length * 100.0;
    } else {
      ordersGrowth =
          ((todayOrdersList.length - yesterdayOrdersList.length) /
              yesterdayOrdersList.length) *
          100;
    }

    // ====== Рост / падение выручки по месяцам ======
    double revenueGrowth;
    if (prevMonthRevenue == 0) {
      revenueGrowth = monthRevenue == 0 ? 0.0 : 100.0;
    } else {
      revenueGrowth =
          ((monthRevenue - prevMonthRevenue) / prevMonthRevenue) * 100;
    }

    final deliveredOrders = event.orders
        .where((o) => o.status == 'delivered')
        .length;
    final pendingOrders = event.orders
        .where((o) => o.status == 'pending')
        .length;

    emit(
      StoreAnalyticsLoaded(
        totalOrders: event.orders.length,
        todayOrders: todayOrdersList.length,
        totalRevenue: monthRevenue,
        deliveredOrders: deliveredOrders,
        pendingOrders: pendingOrders,
        ordersGrowth: ordersGrowth,
        revenueGrowth: revenueGrowth,
        revenuePoints7Days: getRevenuePoints(event.orders, 7),
        revenuePoints30Days: getRevenuePoints(event.orders, 30),
        revenuePoints90Days: getRevenuePoints(event.orders, 90),
        ordersPoints7Days: getOrdersPoints(event.orders, 7),
        ordersPoints30Days: getOrdersPoints(event.orders, 30),
        ordersPoints90Days: getOrdersPoints(event.orders, 90),
        todayOrdersList: todayOrdersList, // 👉 пробросили
      ),
    );
  }

  /// Получаем точки выручки
  List<RevenuePoint> getRevenuePoints(List<CurrentOrder> orders, int days) {
    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: days - 1));

    Map<DateTime, double> revenueMap = {};
    for (int i = 0; i < days; i++) {
      final day = DateTime(startDate.year, startDate.month, startDate.day + i);
      revenueMap[day] = 0.0;
    }

    for (var order in orders) {
      final day = DateTime(
        order.createdAt.toDate().year,
        order.createdAt.toDate().month,
        order.createdAt.toDate().day,
      );
      if (revenueMap.containsKey(day)) {
        revenueMap[day] = revenueMap[day]! + order.totalPrice;
      }
    }

    return revenueMap.entries
        .map((e) => RevenuePoint(date: e.key, revenue: e.value))
        .toList();
  }

  /// Получаем точки количества заказов
  List<RevenuePoint> getOrdersPoints(List<CurrentOrder> orders, int days) {
    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: days - 1));

    Map<DateTime, double> ordersMap = {};
    for (int i = 0; i < days; i++) {
      final day = DateTime(startDate.year, startDate.month, startDate.day + i);
      ordersMap[day] = 0.0;
    }

    for (var order in orders) {
      final day = DateTime(
        order.createdAt.toDate().year,
        order.createdAt.toDate().month,
        order.createdAt.toDate().day,
      );
      if (ordersMap.containsKey(day)) {
        ordersMap[day] = ordersMap[day]! + 1; // считаем количество заказов
      }
    }

    return ordersMap.entries
        .map((e) => RevenuePoint(date: e.key, revenue: e.value))
        .toList();
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
