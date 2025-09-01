part of 'multi_store_orders_bloc.dart';

sealed class MultiStoreOrdersState extends Equatable {
  const MultiStoreOrdersState();

  @override
  List<Object> get props => [];
}

final class MultiStoreOrdersInitial extends MultiStoreOrdersState {}

final class MultiStoreOrdersLoading extends MultiStoreOrdersState {}

final class MultiStoreOrdersLoaded extends MultiStoreOrdersState {
  // key = storeId, value = список заказов
  final Map<String, List<CurrentOrder>> ordersByStore;

  const MultiStoreOrdersLoaded(this.ordersByStore);

  @override
  List<Object> get props => [ordersByStore];
}

final class MultiStoreOrdersError extends MultiStoreOrdersState {
  final String message;
  const MultiStoreOrdersError(this.message);

  @override
  List<Object> get props => [message];
}
