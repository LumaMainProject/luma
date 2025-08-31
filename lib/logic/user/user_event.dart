part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

// Загрузка и установка профиля
class LoadUser extends UserEvent {
  final String uid;
  const LoadUser(this.uid);

  @override
  List<Object?> get props => [uid];
}

class SetUserProfile extends UserEvent {
  final UserProfile profile;
  const SetUserProfile(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ClearUser extends UserEvent {
  @override
  List<Object?> get props => [];
}

// Ошибки
class UserErrorEvent extends UserEvent {
  final String message;
  const UserErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}

// 🔹 Изменение пола
class ChangeGenderEvent extends UserEvent {
  final Gender newGender;
  const ChangeGenderEvent({required this.newGender});

  @override
  List<Object?> get props => [newGender];
}

// 🔹 Изменение имени
class ChangeNameEvent extends UserEvent {
  final String newName;
  const ChangeNameEvent({required this.newName});

  @override
  List<Object?> get props => [newName];
}

// 🔹 Изменение email
class ChangeEmailEvent extends UserEvent {
  final String newEmail;
  const ChangeEmailEvent({required this.newEmail});

  @override
  List<Object?> get props => [newEmail];
}

// 🔹 Изменение телефона
class ChangePhoneEvent extends UserEvent {
  final String newPhone;
  const ChangePhoneEvent({required this.newPhone});

  @override
  List<Object?> get props => [newPhone];
}

// 🔹 Изменение даты рождения
class ChangeBirthdayEvent extends UserEvent {
  final DateTime newBirthDate;
  const ChangeBirthdayEvent({required this.newBirthDate});

  @override
  List<Object?> get props => [newBirthDate];
}

// 🔹 Изменение языка интерфейса
class ChangeLanguageEvent extends UserEvent {
  final String newLanguage;
  const ChangeLanguageEvent({required this.newLanguage});

  @override
  List<Object?> get props => [newLanguage];
}

// 🔹 Изменение корзины
class UpdateProductQuantity extends UserEvent {
  final Product product;
  final int delta;
  const UpdateProductQuantity({required this.product, required this.delta});

  @override
  List<Object?> get props => [product, delta];
}

// 🔹 Избранное
class AddToFavorites extends UserEvent {
  final String productId;
  const AddToFavorites(this.productId);

  @override
  List<Object?> get props => [productId];
}

class RemoveFromFavorites extends UserEvent {
  final String productId;
  const RemoveFromFavorites(this.productId);

  @override
  List<Object?> get props => [productId];
}

class PlaceOrder extends UserEvent {
  final List<CurrentOrder> orders;
  const PlaceOrder(this.orders);
  
  @override
  List<Object?> get props => [orders];
}
