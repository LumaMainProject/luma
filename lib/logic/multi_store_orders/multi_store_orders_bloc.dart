import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luma_2/data/models/user_profile.dart';
import 'package:luma_2/data/repositories/orders_repository.dart';

part 'multi_store_orders_event.dart';
part 'multi_store_orders_state.dart';

class MultiStoreOrdersBloc
    extends Bloc<MultiStoreOrdersEvent, MultiStoreOrdersState> {
  final OrdersRepository repository;

  // храним подписки по каждому магазину
  final Map<String, StreamSubscription> _subscriptions = {};
  // заказы по магазинам
  final Map<String, List<CurrentOrder>> _ordersByStore = {};

  MultiStoreOrdersBloc({required this.repository})
    : super(MultiStoreOrdersInitial()) {
    on<LoadStoreOrders>((event, emit) async {
      emit(MultiStoreOrdersLoading());

      // отменяем старую подписку, если была
      await _subscriptions[event.storeId]?.cancel();

      // подписываемся на поток заказов магазина
      final sub = repository
          .getOrdersByStore(event.storeId)
          .listen((orders) => add(StoreOrdersUpdated(event.storeId, orders)));

      _subscriptions[event.storeId] = sub;
    });

    on<StoreOrdersUpdated>((event, emit) {
      _ordersByStore[event.storeId] = event.orders;
      emit(MultiStoreOrdersLoaded(Map.from(_ordersByStore)));
    });

    on<UpdateOrderStatusEvent>((event, emit) async {
      try {
        await repository.updateOrderStatus(event.orderId, event.newStatus);
      } catch (e) {
        emit(MultiStoreOrdersError("Ошибка обновления заказа: $e"));
      }
    });

    // Очистка
    on<MultiStoreClearOrders>((event, emit) async {
      // Отменяем все подписки по магазинам
      for (final sub in _subscriptions.values) {
        await sub.cancel();
      }
      _subscriptions.clear();
      _ordersByStore.clear(); // очищаем сам Map с заказами
      emit(MultiStoreOrdersInitial());
    });
  }

  @override
  Future<void> close() async {
    for (final sub in _subscriptions.values) {
      await sub.cancel();
    }
    return super.close();
  }
}
