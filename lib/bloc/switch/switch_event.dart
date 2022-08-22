part of 'switch_bloc.dart';

abstract class SwitchEvent extends Equatable {
  const SwitchEvent();

  @override
  List<Object> get props => [];
}

class SwitchOn extends SwitchEvent {
  // final Task task;
  //   const DeleteTask({
  //   required this.task,
  // });
  
  // @override
  // List<Object> get props => [task];
}

class SwitchOff extends SwitchEvent {
  // final Task task;
  //   const DeleteTask({
  //   required this.task,
  // });
  
  // @override
  // List<Object> get props => [task];
}