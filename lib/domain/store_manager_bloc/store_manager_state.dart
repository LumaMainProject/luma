part of 'store_manager_bloc.dart';

sealed class StoreManagerState extends Equatable {
  const StoreManagerState();

  @override
  List<Object> get props => [];
}

final class StoreManagerInitial extends StoreManagerState {}

final class StoreManagerLoaded extends StoreManagerState {
  final List<ObjectShop> shops;
  final List<ObjectItem> itemsPromos;
  final List<ObjectItem> itemsNewArrivals;
  final List<ObjectItem> itemsSuggested;
  final Map<ObjectItem, ObjectShop> itemToShopDictionary;

  const StoreManagerLoaded({
    required this.shops,
    required this.itemsNewArrivals,
    required this.itemsPromos,
    required this.itemsSuggested,
    required this.itemToShopDictionary
  });

  @override
  List<Object> get props => [
    shops,
    itemsPromos,
    itemsNewArrivals,
    itemsSuggested,
    itemToShopDictionary,
  ];
}
