part of 'store_manager_bloc.dart';

sealed class StoreManagerEvent extends Equatable {
  const StoreManagerEvent();

  @override
  List<Object> get props => [];
}


class StoreManagerLoadEvent extends StoreManagerEvent {
  final List<ObjectShop> shops;
  const StoreManagerLoadEvent({required this.shops});
}