part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent {
  final String uid;
  LoadUser(this.uid);

  @override
  List<Object?> get props => [uid];
}

class SetUserProfile extends UserEvent {
  final UserProfile profile;
  SetUserProfile(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ClearUser extends UserEvent {}

class AddToFavorites extends UserEvent {
  final String productId;
  AddToFavorites(this.productId);

  @override
  List<Object?> get props => [productId];
}

class RemoveFromFavorites extends UserEvent {
  final String productId;
  RemoveFromFavorites(this.productId);

  @override
  List<Object?> get props => [productId];
}

class UpdateProductQuantity extends UserEvent {
  final Product product;
  final int delta;

  UpdateProductQuantity({required this.product, required this.delta});
}

class UserErrorEvent extends UserEvent {
  final String message;
  UserErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}
