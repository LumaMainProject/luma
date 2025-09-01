import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/data/repositories/store_repository.dart';

part 'stores_state.dart';

class StoresCubit extends Cubit<StoresState> {
  final StoresRepository repository;
  StreamSubscription<List<Store>>? _storesSub;

  StoresCubit(this.repository) : super(StoresInitial()) {
    _loadStores();
  }

  void _loadStores() {
    emit(StoresLoading());

    _storesSub = repository.listenStores().listen(
      (stores) {
        emit(StoresLoaded(stores));
      },
      onError: (error) {
        emit(StoresError(error.toString()));
      },
    );
  }

  void loadStoresForOwner(String ownerId) {
    _storesSub?.cancel();
    _storesSub = repository.listenStores().listen(
      (stores) => emit(
        StoresLoaded(stores.where((s) => s.ownerId == ownerId).toList()),
      ),
      onError: (error) => emit(StoresError(error.toString())),
    );
  }

  /// Добавление нового магазина
  Future<void> addStore(Store store) async {
    try {
      await repository.addStore(store);
    } catch (e) {
      emit(StoresError('Ошибка добавления магазина: $e'));
    }
  }

  /// Обновление магазина
  Future<void> updateStore(Store store) async {
    try {
      await repository.updateStore(store);
    } catch (e) {
      emit(StoresError('Ошибка обновления магазина: $e'));
    }
  }

  /// Удаление магазина
  Future<void> deleteStore(String id) async {
    try {
      await repository.deleteStore(id);
    } catch (e) {
      emit(StoresError('Ошибка удаления магазина: $e'));
    }
  }

  @override
  Future<void> close() {
    _storesSub?.cancel(); // Отмена подписки при закрытии
    return super.close();
  }
}
