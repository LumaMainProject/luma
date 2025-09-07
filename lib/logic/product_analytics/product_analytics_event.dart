part of 'product_analytics_bloc.dart';

abstract class ProductAnalyticsEvent extends Equatable {
  const ProductAnalyticsEvent();
  @override
  List<Object?> get props => [];
}

class LoadProductAnalytics extends ProductAnalyticsEvent {
  final String productId;
  const LoadProductAnalytics(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ProductOrdersUpdated extends ProductAnalyticsEvent {
  final List<CurrentOrder> orders;
  const ProductOrdersUpdated({required this.orders});

  @override
  List<Object?> get props => [orders];
}
