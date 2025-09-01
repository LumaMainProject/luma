import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/data/repositories/store_repository.dart';

part 'seller_stores_event.dart';
part 'seller_stores_state.dart';

class SellerStoresBloc extends Bloc<SellerStoresEvent, SellerStoresState> {
  final StoresRepository repository;
  StreamSubscription<List<Store>>? _storesSub;

  SellerStoresBloc(this.repository) : super(SellerStoresInitial()) {
    on<LoadSellerStores>((event, emit) async {
      emit(SellerStoresLoading());

      await _storesSub?.cancel();

      _storesSub = repository.listenStores().listen(
        null,
      ); // временная инициализация

      await for (final stores in repository.listenStores()) {
        final sellerStores = stores
            .where((s) => s.ownerId == event.sellerId)
            .toList();
        if (!emit.isDone) {
          emit(SellerStoresLoaded(sellerStores));
        }
      }
    });

    on<ClearSellerStores>((event, emit) async {
      await _storesSub?.cancel();
      emit(SellerStoresInitial());
    });
  }

  @override
  Future<void> close() async {
    await _storesSub?.cancel();
    return super.close();
  }
}
