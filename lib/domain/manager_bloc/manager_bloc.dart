import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'manager_event.dart';
part 'manager_state.dart';

class ManagerBloc extends Bloc<ManagerEvent, ManagerState> {
  ManagerBloc() : super(ManagerInitial()) {
    on<ManagerEvent>((event, emit) {});
  }
}
