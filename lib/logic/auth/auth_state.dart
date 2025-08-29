part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

/// Нет авторизации
class Unauthenticated extends AuthState {}

/// Гость (Firebase anonymous user)
class GuestAuthenticated extends AuthState {
  final User user;
  const GuestAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Firebase-пользователь (обычная авторизация через Firebase)
class Authenticated extends AuthState {
  final User user;
  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Авторизация через Firestore профиль (финальная тестовая)
class AuthenticatedProfile extends AuthState {
  final UserProfile profile;
  const AuthenticatedProfile(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// Email ссылка отправлена
class LinkSent extends AuthState {
  final String email;
  const LinkSent(this.email);

  @override
  List<Object?> get props => [email];
}
