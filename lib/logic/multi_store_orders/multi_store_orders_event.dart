part of 'multi_store_orders_bloc.dart';

sealed class MultiStoreOrdersEvent extends Equatable {
  const MultiStoreOrdersEvent();

  @override
  List<Object> get props => [];
}

// Загружаем заказы конкретного магазина
final class LoadStoreOrders extends MultiStoreOrdersEvent {
  final String storeId;
  const LoadStoreOrders(this.storeId);

  @override
  List<Object> get props => [storeId];
}

// Получили обновления заказов для магазина
final class StoreOrdersUpdated extends MultiStoreOrdersEvent {
  final String storeId;
  final List<CurrentOrder> orders;
  const StoreOrdersUpdated(this.storeId, this.orders);

  @override
  List<Object> get props => [storeId, orders];
}

// Обновление статуса конкретного заказа
final class UpdateOrderStatusEvent extends MultiStoreOrdersEvent {
  final String orderId;
  final String newStatus;

  const UpdateOrderStatusEvent({required this.orderId, required this.newStatus});

  @override
  List<Object> get props => [orderId, newStatus];
}

class MultiStoreClearOrders extends MultiStoreOrdersEvent {}