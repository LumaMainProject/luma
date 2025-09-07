import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/data/models/user_profile.dart';
import 'package:luma_2/data/repositories/orders_repository.dart';

part 'product_analytics_event.dart';
part 'product_analytics_state.dart';

class ProductAnalyticsBloc
    extends Bloc<ProductAnalyticsEvent, ProductAnalyticsState> {
  final OrdersRepository ordersRepository;
  StreamSubscription? _ordersSubscription;

  ProductAnalyticsBloc({required this.ordersRepository})
    : super(ProductAnalyticsInitial()) {
    on<LoadProductAnalytics>(_onLoadProductAnalytics);
    on<ProductOrdersUpdated>(_onProductOrdersUpdated);
  }

  void _onLoadProductAnalytics(
    LoadProductAnalytics event,
    Emitter<ProductAnalyticsState> emit,
  ) {
    _ordersSubscription?.cancel();
    _ordersSubscription = ordersRepository
        .getOrdersByProduct(event.productId)
        .listen((orders) {
          add(ProductOrdersUpdated(orders: orders));
        });
  }

  void _onProductOrdersUpdated(
    ProductOrdersUpdated event,
    Emitter<ProductAnalyticsState> emit,
  ) {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = todayStart.add(Duration(days: 1));

    final todayOrders = event.orders
        .where(
          (o) =>
              o.createdAt.toDate().isAfter(todayStart) &&
              o.createdAt.toDate().isBefore(todayEnd),
        )
        .toList();

    final totalRevenue = event.orders.fold(0.0, (sum, o) => sum + o.totalPrice);
    final deliveredOrders = event.orders
        .where((o) => o.status == 'delivered')
        .length;
    final pendingOrders = event.orders
        .where((o) => o.status == 'pending')
        .length;

    emit(
      ProductAnalyticsLoaded(
        totalOrders: event.orders.length,
        todayOrders: todayOrders.length,
        totalRevenue: totalRevenue,
        deliveredOrders: deliveredOrders,
        pendingOrders: pendingOrders,
      ),
    );
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
