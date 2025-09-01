part of 'seller_stores_bloc.dart';

abstract class SellerStoresState extends Equatable {
  const SellerStoresState();

  @override
  List<Object?> get props => [];
}

class SellerStoresInitial extends SellerStoresState {}

class SellerStoresLoading extends SellerStoresState {}

class SellerStoresLoaded extends SellerStoresState {
  final List<Store> stores;

  const SellerStoresLoaded(this.stores);

  @override
  List<Object?> get props => [stores];
}

class SellerStoresError extends SellerStoresState {
  final String message;

  const SellerStoresError(this.message);

  @override
  List<Object?> get props => [message];
}
