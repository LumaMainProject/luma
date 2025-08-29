import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    // Загрузка пользователя
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

    // Установка профиля
    on<SetUserProfile>((event, emit) => emit(UserLoaded(event.profile)));

    // Очистка
    on<ClearUser>((event, emit) async {
      await _userSub?.cancel();
      emit(UserInitial());
    });

    // Добавление в избранное
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
            emit(UserLoaded(currentUser));
          }
        }
      }
    });

    // Удаление из избранного
    on<RemoveFromFavorites>((event, emit) async {
      if (state is UserLoaded) {
        final currentUser = (state as UserLoaded).user;
        if (currentUser.favoriteProducts.contains(event.productId)) {
          emit(
            UserLoaded(
              currentUser.copyWith(
                favoriteProducts: currentUser.favoriteProducts
                    .where((id) => id != event.productId)
                    .toList(),
              ),
            ),
          );
          try {
            await userRepository.removeProductFromFavorites(
              currentUser.id,
              event.productId,
            );
          } catch (_) {
            emit(UserLoaded(currentUser));
          }
        }
      }
    });

    // Обновление количества в корзине
    on<UpdateProductQuantity>((event, emit) async {
      if (state is UserLoaded) {
        final user = (state as UserLoaded).user;
        final currentOrders = [...user.currentOrders];

        // Ищем существующий заказ с этим productId
        final index = currentOrders.indexWhere(
          (o) => o.productId == event.product.id,
        );

        if (index != -1) {
          // Если есть, обновляем количество
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
          // Если нет, создаём новый заказ
          currentOrders.add(
            CurrentOrder(
              id: '', // сервер сгенерирует
              productId: event.product.id,
              storeId: event.product.sellerId,
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

    on<UserErrorEvent>((event, emit) => emit(UserError(event.message)));
  }

  @override
  Future<void> close() async {
    await _userSub?.cancel();
    return super.close();
  }
}
