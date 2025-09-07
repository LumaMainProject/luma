part of 'product_analytics_bloc.dart';

abstract class ProductAnalyticsState extends Equatable {
  const ProductAnalyticsState();
  @override
  List<Object?> get props => [];
}

class ProductAnalyticsInitial extends ProductAnalyticsState {}

class ProductAnalyticsLoaded extends ProductAnalyticsState {
  final int totalOrders;
  final int todayOrders;
  final double totalRevenue;
  final int deliveredOrders;
  final int pendingOrders;

  const ProductAnalyticsLoaded({
    required this.totalOrders,
    required this.todayOrders,
    required this.totalRevenue,
    required this.deliveredOrders,
    required this.pendingOrders,
  });

  @override
  List<Object?> get props => [
    totalOrders,
    todayOrders,
    totalRevenue,
    deliveredOrders,
    pendingOrders,
  ];
}
