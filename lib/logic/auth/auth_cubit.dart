import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luma_2/data/models/user_profile.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  late final StreamSubscription<User?> _authSub;

  AuthCubit(this.authRepository) : super(AuthInitial()) {
    // Подписываемся на Firebase auth
    _authSub = authRepository.userChanges.listen((user) {
      if (user == null) {
        emit(Unauthenticated());
      } else if (user.isAnonymous) {
        emit(GuestAuthenticated(user));
      } else {
        emit(Authenticated(user));
      }
    });
  }

  // ------------------ Actions ------------------

  /// Отправка magic link по email
  Future<void> sendSignInLink(String email) async {
    await authRepository.sendSignInLink(email);
    emit(LinkSent(email));
  }

  /// Авторизация напрямую по email (только через Firestore)
  /// ⚡ Финальная для тестов
  Future<void> signInWithEmailOnly(String email) async {
    final profile = await authRepository.signInWithEmailOnly(email);
    if (profile == null) {
      emit(Unauthenticated());
    } else {
      emit(AuthenticatedProfile(profile));
    }
  }

  /// Гостевая авторизация (Firebase anonymous)
  Future<void> signInAsGuest() async {
    await authRepository.signInAsGuest();
  }

  /// Выход
  Future<void> signOut() async {
    await authRepository.signOut();
    // ❌ не эмитим руками — состояние придёт из стрима
  }

  @override
  Future<void> close() {
    _authSub.cancel(); // отписка от стрима
    return super.close();
  }
}
