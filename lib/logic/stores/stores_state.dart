part of 'stores_cubit.dart';

abstract class StoresState extends Equatable {
  const StoresState();

  @override
  List<Object?> get props => [];
}

class StoresInitial extends StoresState {}

class StoresLoading extends StoresState {}

class StoresLoaded extends StoresState {
  final List<Store> stores;

  const StoresLoaded(this.stores);

  @override
  List<Object?> get props => [stores];
}

class StoresError extends StoresState {
  final String message;

  const StoresError(this.message);

  @override
  List<Object?> get props => [message];
}
