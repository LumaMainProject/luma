import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/repositories/products_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository _repository;
  StreamSubscription? _productsSub;

  ProductsCubit(this._repository) : super(ProductsInitial()) {
    _loadData();
  }

  void _loadData() {
    emit(ProductsLoading());

    _productsSub = _repository.listenProducts().listen(
      (products) {
        emit(ProductsLoaded(products));
      },
      onError: (error) {
        emit(ProductsError(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _productsSub?.cancel();
    return super.close();
  }
}
