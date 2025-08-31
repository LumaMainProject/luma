part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object?> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationEditing extends RegistrationState {
  final RegistrationData data;
  const RegistrationEditing(this.data);

  @override
  List<Object?> get props => [data];
}

/// 🔹 Состояние, когда идёт отправка данных на сервер
class RegistrationLoading extends RegistrationState {}

/// 🔹 Состояние при успешной регистрации
class RegistrationSuccess extends RegistrationState {}

/// 🔹 Ошибка регистрации
class RegistrationFailure extends RegistrationState {
  final String message;
  const RegistrationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
