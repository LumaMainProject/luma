import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/data/models/enum_gender.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/user_profile.dart';
import 'package:luma_2/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  StreamSubscription<UserProfile>? _userSub;

  UserBloc(this.userRepository) : super(UserInitial()) {
    // 🔹 Загрузка пользователя и стрим изменений
    on<LoadUser>((event, emit) async {
      emit(UserLoading());
      await _userSub?.cancel();
      _userSub = userRepository
          .streamUserProfile(event.uid)
          .listen(
            (profile) => add(SetUserProfile(profile)),
            onError: (error) => add(UserErrorEvent(error.toString())),
          );
    });

    // 🔹 Обновление состояния с новым профилем
    on<SetUserProfile>((event, emit) => emit(UserLoaded(event.profile)));

    // 🔹 Очистка состояния
    on<ClearUser>((event, emit) async {
      await _userSub?.cancel();
      emit(UserInitial());
    });

    // 🔹 Изменение пола
    on<ChangeGenderEvent>((event, emit) async {
      if (state is UserLoaded) {
        final currentUser = (state as UserLoaded).user;

        // 1️⃣ Мгновенное локальное обновление
        final updatedUser = currentUser.copyWith(gender: event.newGender);
        emit(UserLoaded(updatedUser));

        // 2️⃣ Отправка на сервер асинхронно
        try {
          await userRepository.updateUserProfile(updatedUser);
        } catch (e) {
          // Ошибку можно логировать, но локально уже поменяли
          print("Ошибка при обновлении пола: $e");
        }
      }
    });

    // Имя
    on<ChangeNameEvent>((event, emit) async {
      if (state is UserLoaded) {
        final user = (state as UserLoaded).user;
        if (user.name != event.newName) {
          final updatedUser = user.copyWith(name: event.newName);
          emit(UserLoaded(updatedUser));
          try {
            await userRepository.updateUserProfile(updatedUser);
          } catch (_) {
            emit(UserLoaded(user)); // откат при ошибке
          }
        }
      }
    });

    // Email
    on<ChangeEmailEvent>((event, emit) async {
      if (state is UserLoaded) {
        final user = (state as UserLoaded).user;
        final updatedEmails = [...user.emails];
        if (!updatedEmails.contains(event.newEmail)) {
          updatedEmails.add(event.newEmail);
          final updatedUser = user.copyWith(emails: updatedEmails);
          emit(UserLoaded(updatedUser));
          try {
            await userRepository.updateUserProfile(updatedUser);
          } catch (_) {
            emit(UserLoaded(user));
          }
        }
      }
    });

    // Телефон
    on<ChangePhoneEvent>((event, emit) async {
      if (state is UserLoaded) {
        final user = (state as UserLoaded).user;
        final updatedPhones = [...user.phones];
        if (!updatedPhones.contains(event.newPhone)) {
          updatedPhones.add(event.newPhone);
          final updatedUser = user.copyWith(phones: updatedPhones);
          emit(UserLoaded(updatedUser));
          try {
            await userRepository.updateUserProfile(updatedUser);
          } catch (_) {
            emit(UserLoaded(user));
          }
        }
      }
    });

    // Дата рождения
    on<ChangeBirthdayEvent>((event, emit) async {
      if (state is UserLoaded) {
        final user = (state as UserLoaded).user;
        if (user.birthDate != event.newBirthDate) {
          final updatedUser = user.copyWith(birthDate: event.newBirthDate);
          emit(UserLoaded(updatedUser));
          try {
            await userRepository.updateUserProfile(updatedUser);
          } catch (_) {
            emit(UserLoaded(user));
          }
        }
      }
    });

    // Язык интерфейса
    on<ChangeLanguageEvent>((event, emit) async {
      if (state is UserLoaded) {
        final user = (state as UserLoaded).user;
        if (user.language != event.newLanguage) {
          final updatedUser = user.copyWith(language: event.newLanguage);
          emit(UserLoaded(updatedUser));
          try {
            await userRepository.updateUserProfile(updatedUser);
          } catch (_) {
            emit(UserLoaded(user));
          }
        }
      }
    });

    // 🔹 Добавление в избранное
    on<AddToFavorites>((event, emit) async {
      if (state is UserLoaded) {
        final currentUser = (state as UserLoaded).user;
        if (!currentUser.favoriteProducts.contains(event.productId)) {
          emit(
            UserLoaded(
              currentUser.copyWith(
                favoriteProducts: [
                  ...currentUser.favoriteProducts,
                  event.productId,
                ],
              ),
            ),
          );
          try {
            await userRepository.addProductToFavorites(
              currentUser.id,
              event.productId,
            );
          } catch (_) {
            emit(UserLoaded(currentUser)); // откат при ошибке
          }
        }
      }
    });

    // 🔹 Удаление из избранного
    on<RemoveFromFavorites>((event, emit) async {
      if (state is UserLoaded) {
        final currentUser = (state as UserLoaded).user;
        if (currentUser.favoriteProducts.contains(event.productId)) {
          final updatedFavorites = currentUser.favoriteProducts
              .where((id) => id != event.productId)
              .toList();
          emit(
            UserLoaded(
              currentUser.copyWith(favoriteProducts: updatedFavorites),
            ),
          );

          try {
            await userRepository.removeProductFromFavorites(
              currentUser.id,
              event.productId,
            );
          } catch (_) {
            emit(UserLoaded(currentUser)); // откат при ошибке
          }
        }
      }
    });

    // 🔹 Обновление количества в корзине
    on<UpdateProductQuantity>((event, emit) async {
      if (state is UserLoaded) {
        final user = (state as UserLoaded).user;
        final currentOrders = [...user.currentOrders];

        final index = currentOrders.indexWhere(
          (o) => o.productId == event.product.id,
        );

        if (index != -1) {
          final oldOrder = currentOrders[index];
          final newQty = (oldOrder.quantity + event.delta).clamp(0, 999);
          if (newQty == 0) {
            currentOrders.removeAt(index);
          } else {
            currentOrders[index] = oldOrder.copyWith(
              quantity: newQty,
              totalPrice: newQty * oldOrder.unitPrice,
            );
          }
        } else if (event.delta > 0) {
          currentOrders.add(
            CurrentOrder(
              id: '', // сервер сгенерирует
              productId: event.product.id,
              storeId: event.product.sellerId,
              userId: user.id, // добавлено
              quantity: event.delta,
              unitPrice: event.product.price,
              totalPrice: event.product.price * event.delta,
            ),
          );
        }

        emit(UserLoaded(user.copyWith(currentOrders: currentOrders)));

        try {
          await userRepository.updateUserProfile(
            user.copyWith(currentOrders: currentOrders),
          );
        } catch (_) {
          emit(UserLoaded(user)); // откат при ошибке
        }
      }
    });

    // 🔹 Оформление заказа
    on<PlaceOrder>((event, emit) async {
      if (state is UserLoaded) {
        final user = (state as UserLoaded).user;

        // Локально очищаем корзину и добавляем id заказов в inTrackOrders
        final updatedUser = user.copyWith(
          currentOrders: [],
          inTrackOrders: [
            ...user.inTrackOrders,
            ...List.generate(
              event.orders.length,
              (_) => "",
            ), // временные пустые id
          ],
        );

        emit(UserLoaded(updatedUser));

        try {
          // Создаём заказы на сервере и получаем реальные id
          final orderIds = await userRepository.placeOrder(
            user.id,
            event.orders,
          );

          final finalUser = updatedUser.copyWith(
            inTrackOrders: [...user.inTrackOrders, ...orderIds],
          );

          emit(UserLoaded(finalUser));
        } catch (e) {
          emit(UserLoaded(user)); // откат при ошибке
        }
      }
    });

    // 🔹 Ошибки
    on<UserErrorEvent>((event, emit) => emit(UserError(event.message)));
  }

  @override
  Future<void> close() async {
    await _userSub?.cancel();
    return super.close();
  }
}
