part of 'seller_stores_bloc.dart';

abstract class SellerStoresEvent extends Equatable {
  const SellerStoresEvent();

  @override
  List<Object?> get props => [];
}

class LoadSellerStores extends SellerStoresEvent {
  final String sellerId;

  const LoadSellerStores(this.sellerId);

  @override
  List<Object?> get props => [sellerId];
}

class ClearSellerStores extends SellerStoresEvent {}
