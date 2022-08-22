part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> pendingTask;
  final List<Task> removedTask;
  final List<Task> favoritedTask;
  final List<Task> completedTask;
  final List<Task> restoreTask;
  
  const TasksState({
    this.pendingTask = const<Task>[],
    this.removedTask = const<Task>[],
    this.favoritedTask = const<Task>[],
    this.completedTask = const<Task>[],
    this.restoreTask = const<Task>[]
  });
  
  @override
  List<Object> get props => [pendingTask, removedTask, completedTask, favoritedTask, restoreTask];
}

