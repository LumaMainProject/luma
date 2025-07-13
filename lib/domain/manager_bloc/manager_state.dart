part of 'manager_bloc.dart';

sealed class ManagerState extends Equatable {
  const ManagerState();
  
  @override
  List<Object> get props => [];
}

final class ManagerInitial extends ManagerState {}

final class ManagerLoaded extends ManagerState {}
