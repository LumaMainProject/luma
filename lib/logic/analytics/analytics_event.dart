part of 'analytics_bloc.dart';

abstract class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();
  @override
  List<Object?> get props => [];
}

class LoadStoreAnalytics extends AnalyticsEvent {
  final String storeId;
  const LoadStoreAnalytics(this.storeId);

  @override
  List<Object?> get props => [storeId];
}

class OrdersUpdated extends AnalyticsEvent {
  final List<CurrentOrder> orders;
  const OrdersUpdated({required this.orders});

  @override
  List<Object?> get props => [orders];
}
