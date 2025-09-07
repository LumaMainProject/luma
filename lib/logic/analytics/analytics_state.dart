part of 'analytics_bloc.dart';

abstract class AnalyticsState extends Equatable {
  const AnalyticsState();
  @override
  List<Object?> get props => [];
}

class AnalyticsInitial extends AnalyticsState {}

class StoreAnalyticsLoaded extends AnalyticsState {
  final int totalOrders;
  final int todayOrders;
  final double totalRevenue;
  final int deliveredOrders;
  final int pendingOrders;
  final double ordersGrowth; // в процентах
  final double revenueGrowth; // в процентах

  // Точки для графиков выручки
  final List<RevenuePoint> revenuePoints7Days;
  final List<RevenuePoint> revenuePoints30Days;
  final List<RevenuePoint> revenuePoints90Days;

  // Точки для графиков заказов
  final List<RevenuePoint> ordersPoints7Days;
  final List<RevenuePoint> ordersPoints30Days;
  final List<RevenuePoint> ordersPoints90Days;

  const StoreAnalyticsLoaded({
    required this.totalOrders,
    required this.todayOrders,
    required this.totalRevenue,
    required this.deliveredOrders,
    required this.pendingOrders,
    required this.ordersGrowth,
    required this.revenueGrowth,
    required this.revenuePoints7Days,
    required this.revenuePoints30Days,
    required this.revenuePoints90Days,
    required this.ordersPoints7Days,
    required this.ordersPoints30Days,
    required this.ordersPoints90Days,
  });

  @override
  List<Object?> get props => [
    totalOrders,
    todayOrders,
    totalRevenue,
    deliveredOrders,
    pendingOrders,
    ordersGrowth,
    revenueGrowth,
    revenuePoints7Days,
    revenuePoints30Days,
    revenuePoints90Days,
    ordersPoints7Days,
    ordersPoints30Days,
    ordersPoints90Days,
  ];
}
