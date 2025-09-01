part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

// Загрузка заказов для текущего пользователя
final class LoadOrders extends OrdersEvent {
  final String userId;
  const LoadOrders(this.userId);

  @override
  List<Object> get props => [userId];
}

final class OrdersUpdated extends OrdersEvent {
  final List<CurrentOrder> orders;
  const OrdersUpdated(this.orders);

  @override
  List<Object> get props => [orders];
}

final class UpdateOrderStatusEvent extends OrdersEvent {
  final String orderId;
  final String newStatus;

  const UpdateOrderStatusEvent({
    required this.orderId,
    required this.newStatus,
  });

  @override
  List<Object> get props => [orderId, newStatus];
}

class ClearOrders extends OrdersEvent {}