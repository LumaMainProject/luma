part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

class StartRegistration extends RegistrationEvent {}

class SetEmail extends RegistrationEvent {
  final String email;
  const SetEmail(this.email);

  @override
  List<Object?> get props => [email];
}

class VerifyEmail extends RegistrationEvent {}

class SetName extends RegistrationEvent {
  final String name;
  const SetName(this.name);

  @override
  List<Object?> get props => [name];
}

class SetAgreements extends RegistrationEvent {
  final bool agreedToTerms;
  final bool agreedToEmails;
  const SetAgreements({
    required this.agreedToTerms,
    required this.agreedToEmails,
  });

  @override
  List<Object?> get props => [agreedToTerms, agreedToEmails];
}

/// 🔹 Финальное событие: отправка данных на сервер
class SubmitRegistration extends RegistrationEvent {}
