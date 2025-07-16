part of 'seller_account_bloc.dart';

sealed class SellerAccountEvent extends Equatable {
  const SellerAccountEvent();

  @override
  List<Object> get props => [];
}

class SellerAccountLoadEvent extends SellerAccountEvent {
  final ObjectShop shop;
  const SellerAccountLoadEvent({required this.shop});
}
