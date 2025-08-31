import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:luma_2/data/models/registration_data.dart';
import 'package:luma_2/data/models/user_profile.dart';
import 'package:luma_2/data/repositories/user_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<StartRegistration>((event, emit) {
      emit(RegistrationEditing(RegistrationData(createdAt: Timestamp.now())));
    });

    on<SetEmail>((event, emit) {
      if (state is RegistrationEditing) {
        final data = (state as RegistrationEditing).data;
        emit(RegistrationEditing(data.copyWith(email: event.email)));
      }
    });

    on<VerifyEmail>((event, emit) {
      if (state is RegistrationEditing) {
        final data = (state as RegistrationEditing).data;
        emit(RegistrationEditing(data.copyWith(emailVerified: true)));
      }
    });

    on<SetName>((event, emit) {
      if (state is RegistrationEditing) {
        final data = (state as RegistrationEditing).data;
        emit(RegistrationEditing(data.copyWith(name: event.name)));
      }
    });

    on<SetAgreements>((event, emit) {
      if (state is RegistrationEditing) {
        final data = (state as RegistrationEditing).data;
        emit(
          RegistrationEditing(
            data.copyWith(
              agreedToTerms: event.agreedToTerms,
              agreedToEmails: event.agreedToEmails,
            ),
          ),
        );
      }
    });

    on<SubmitRegistration>((event, emit) async {
      if (state is RegistrationEditing) {
        final data = (state as RegistrationEditing).data;
        emit(RegistrationLoading());

        try {
          final userRepo = UserRepository();

          // 🔹 Генерируем новый UID прямо через Firestore
          final docRef = FirebaseFirestore.instance.collection("users").doc();
          final uid = docRef.id;

          // 🔹 Конвертируем RegistrationData → UserProfile
          final profile = UserProfile(
            id: uid,
            name: data.name,
            emails: data.email.isNotEmpty ? [data.email] : [],
            role: data.role,
            createdAt: data.createdAt,
            updatedAt: Timestamp.now(),
          );

          // 🔹 Сохраняем в Firestore
          await userRepo.updateUserProfile(profile);

          emit(RegistrationSuccess());
        } catch (e) {
          emit(RegistrationFailure("Ошибка при регистрации: $e"));
        }
      }
    });
  }
}
