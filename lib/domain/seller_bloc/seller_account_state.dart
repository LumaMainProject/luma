part of 'seller_account_bloc.dart';

sealed class SellerAccountState extends Equatable {
  const SellerAccountState();
  
  @override
  List<Object> get props => [];
}

final class SellerAccountInitial extends SellerAccountState {}

final class SellerAccountLoaded extends SellerAccountState {
  final List<ObjectItem> items;
  final ObjectShop shop;

  const SellerAccountLoaded({required this.items, required this.shop});

  @override
  List<Object> get props => [items, shop];
}