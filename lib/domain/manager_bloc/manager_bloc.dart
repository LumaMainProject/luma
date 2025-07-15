import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'manager_event.dart';
part 'manager_state.dart';

class ManagerBloc extends Bloc<ManagerEvent, ManagerState> {
  ManagerBloc() : super(ManagerInitial()) {
    on<ManagerLoadEvent>(_load);
    on<ManagerPageChangeEvent>(_pageChange);
  }

  Future<void> _load(ManagerLoadEvent event, Emitter<ManagerState> emit) async {
    int currentPage = event.currentPage;
    final baseState = ManagerLoaded(currentPage: currentPage);

    emit(baseState);
  }

  Future<void> _pageChange(
    ManagerPageChangeEvent event,
    Emitter<ManagerState> emit,
  ) async {
    if (this.state is! ManagerLoaded) return;

    final state = this.state as ManagerLoaded;

    int currentPage = event.currentPage;

    final newState = state.copyWith(currentPage: currentPage);

    emit(newState);
  }
}
