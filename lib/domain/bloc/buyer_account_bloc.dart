import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_notification.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/classes/object_user.dart';

part 'buyer_account_event.dart';
part 'buyer_account_state.dart';

class BuyerAccountBloc extends Bloc<BuyerAccountEvent, BuyerAccountState> {
  BuyerAccountBloc() : super(const BuyerAccountInitial()) {
    on<BuyerAccountLoadEvent>(_load);
    on<AddActualOrdersEvent>(_addActualOrderEvent);
    on<RemoveActualOrdersEvent>(_removeActualOrderEvent);
  }

  Future<void> _load(
    BuyerAccountLoadEvent event,
    Emitter<BuyerAccountState> emit,
  ) async {
    final baseState = const BuyerAccountLoaded(
      number: 998901234567,
      gender: Gender.male,
      isSeller: false,
      actualOrders: [],
    );

    emit(baseState);
  }

  Future<void> _addActualOrderEvent(
    AddActualOrdersEvent event,
    Emitter<BuyerAccountState> emit,
  ) async {
    if (this.state is! BuyerAccountLoaded) return;

    final state = this.state as BuyerAccountLoaded;

    List<ObjectItem> newActualOrders;

    if (state.actualOrders.isEmpty) {
      newActualOrders = [event.item];
    } else {
      newActualOrders = state.actualOrders;
      newActualOrders.add(event.item);
    }

    final newState = state.copyWith(actualOrders: newActualOrders);

    emit(newState);
  }

  Future<void> _removeActualOrderEvent(
    RemoveActualOrdersEvent event,
    Emitter<BuyerAccountState> emit,
  ) async {
    if (this.state is! BuyerAccountLoaded) return;

    final state = this.state as BuyerAccountLoaded;

    List<ObjectItem> newActualOrders;

    newActualOrders = state.actualOrders;
    newActualOrders.remove(event.item);

    final newState = state.copyWith(actualOrders: newActualOrders);

    emit(newState);
  }
}
