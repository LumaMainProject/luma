part of 'buyer_account_bloc.dart';

sealed class BuyerAccountEvent extends Equatable {
  const BuyerAccountEvent();

  @override
  List<Object> get props => [];
}

// Load state event
class BuyerAccountLoadEvent extends BuyerAccountEvent {
  const BuyerAccountLoadEvent();
}

class AddActualOrdersEvent extends BuyerAccountEvent {
  final ObjectItem item;
  const AddActualOrdersEvent({required this.item});
}

class RemoveActualOrdersEvent extends BuyerAccountEvent {
  final ObjectItem item;
  const RemoveActualOrdersEvent({required this.item});
}
