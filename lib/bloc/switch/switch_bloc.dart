import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchInitial(switchValue: false)) {
    on<SwitchOn>((event, emit) {
      emit(const SwitchState(switchValue: true));
    });

    on<SwitchOff>((event, emit) {
      emit(const SwitchState(switchValue: false));
    });
  }
}
