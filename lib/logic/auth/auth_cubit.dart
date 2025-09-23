import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luma_2/data/models/user_profile.dart';
import 'package:luma_2/data/models/user_role.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  late final StreamSubscription<User?> _authSub;

  UserRole? role; // ✅ добавляем роль

  AuthCubit(this.authRepository) : super(AuthInitial()) {
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

  void setRole(UserRole newRole) {
    role = newRole;
    emit(RoleSelected(newRole));
  }

  Future<void> sendSignInLink(String email) async {
    await authRepository.sendSignInLink(email);
    emit(LinkSent(email));
  }

  Future<void> signInWithEmailOnly(String email) async {
    final profile = await authRepository.signInWithEmailOnly(email);
    if (profile == null) {
      emit(Unauthenticated());
    } else {
      emit(AuthenticatedProfile(profile));
    }
  }

  Future<void> signInAsGuest() async {
    await authRepository.signInAsGuest();
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    emit(Unauthenticated());
  }

  @override
  Future<void> close() {
    _authSub.cancel();
    return super.close();
  }
}
