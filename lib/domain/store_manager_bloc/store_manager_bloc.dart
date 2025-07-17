import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';

part 'store_manager_event.dart';
part 'store_manager_state.dart';

class StoreManagerBloc extends Bloc<StoreManagerEvent, StoreManagerState> {
  StoreManagerBloc() : super(StoreManagerInitial()) {
    on<StoreManagerLoadEvent>(_load);
  }

  Future<void> _load(
    StoreManagerLoadEvent event,
    Emitter<StoreManagerState> emit,
  ) async {
    final List<ObjectShop> shops = event.shops;

    // LISTS
    final List<ObjectItem> itemsPromos = [];
    final List<ObjectItem> itemsNewArrivals = [];
    final List<ObjectItem> itemsSuggested = [];

    for (ObjectShop shop in shops) {
      for (ObjectItem item in shop.items) {
        itemsPromos.add(item);
        itemsNewArrivals.add(item);
        itemsSuggested.add(item);
      }
    }
    
    itemsPromos.shuffle();
    itemsNewArrivals.shuffle();
    itemsSuggested.shuffle();

    // DICTIONARY
    final Map<ObjectItem, ObjectShop> itemToShopDictionary = {};

    for (ObjectShop shop in shops) {
      for (ObjectItem item in shop.items) {
        itemToShopDictionary[item] = shop;
      }
    }

    final baseState = StoreManagerLoaded(
      shops: event.shops,
      itemsNewArrivals: itemsNewArrivals,
      itemsPromos: itemsPromos,
      itemsSuggested: itemsSuggested,
      itemToShopDictionary: itemToShopDictionary,
    );

    emit(baseState);
  }
}
