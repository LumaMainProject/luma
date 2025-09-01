import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luma_2/data/models/user_profile.dart';
import 'package:luma_2/data/repositories/orders_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository repository;

  StreamSubscription? _ordersSubscription;

  OrdersBloc({required this.repository}) : super(OrdersInitial()) {
    on<LoadOrders>((event, emit) async {
      emit(OrdersLoading());
      await _ordersSubscription?.cancel();
      _ordersSubscription = repository
          .getOrdersByUser(event.userId)
          .listen((orders) => add(OrdersUpdated(orders)));
    });

    on<OrdersUpdated>((event, emit) {
      emit(OrdersLoaded(event.orders));
    });

    on<UpdateOrderStatusEvent>((event, emit) async {
      try {
        await repository.updateOrderStatus(event.orderId, event.newStatus);
      } catch (e) {
        emit(OrdersError("Ошибка обновления заказа: $e"));
      }
    });

    // Очистка
    on<ClearOrders>((event, emit) async {
      await _ordersSubscription?.cancel();
      emit(OrdersInitial());
    });
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
