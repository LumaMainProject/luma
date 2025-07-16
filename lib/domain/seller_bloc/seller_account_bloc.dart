import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/saves/saves.dart';

part 'seller_account_event.dart';
part 'seller_account_state.dart';

class SellerAccountBloc extends Bloc<SellerAccountEvent, SellerAccountState> {
  SellerAccountBloc() : super(SellerAccountInitial()) {
    on<SellerAccountLoadEvent>(_load);
  }

  Future<void> _load(
    SellerAccountLoadEvent event,
    Emitter<SellerAccountState> emit,
  ) async {
    List<ObjectItem> list = [];

    for (var element in SaveLists.itemList) {
      if (element.shop == event.shop) {
        list.add(element);
      }
    }

    final baseState = SellerAccountLoaded(items: list, shop: event.shop);

    emit(baseState);
  }
}
