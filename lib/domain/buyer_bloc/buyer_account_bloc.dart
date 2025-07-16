import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_notification.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/classes/object_user.dart';
import 'package:luma/global/params/app_images.dart';

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
    AssetImage avatar = AppImages.appUserAvater;

    final baseState = BuyerAccountLoaded(
      number: 998901234567,
      gender: Gender.female,
      isSeller: false,
      email: "example@email.com",
      creditCard: ["1234 5678 9012 3456"],
      name: "Tasha",
      notifications: [],
      actualOrders: [],
      avatar: avatar,
      birthdate: DateTime(2000, 7, 11),
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
