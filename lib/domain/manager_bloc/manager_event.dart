part of 'manager_bloc.dart';

sealed class ManagerEvent extends Equatable {
  const ManagerEvent();

  @override
  List<Object> get props => [];
}

class ManagerLoadEvent extends ManagerEvent {
  final int currentPage;
  const ManagerLoadEvent({required this.currentPage});
}

class ManagerPageChangeEvent extends ManagerEvent {
  final int currentPage;
  const ManagerPageChangeEvent({required this.currentPage});
}
