import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_task_app/model/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrNot>(_onFavoriteTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTask>(_onDeleteAllTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    emit(TasksState(
        pendingTask: List.from(state.pendingTask)..add(task),
        removedTask: state.removedTask,
        completedTask: state.completedTask,
        favoritedTask: state.favoritedTask));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTask = state.pendingTask;
    List<Task> completedTask = state.completedTask;
    List<Task> favoritedTask = state.favoritedTask;

    if (task.isDone == false) {
      if (task.isFavorite == false) {
        pendingTask = List.from(pendingTask)..remove(task);
        completedTask = List.from(completedTask)
          ..insert(0, task.copyWith(isDone: true));
      } else {
        var index = favoritedTask.indexOf(task);
        pendingTask = List.from(pendingTask)..remove(task);
        completedTask.insert(0, task.copyWith(isDone: true));
        favoritedTask = List.from(favoritedTask)
          ..remove(task)
          ..insert(index, task.copyWith(isDone: true));
      }
    } else {
      if (task.isFavorite == false) {
        completedTask = List.from(completedTask)..remove(task);
        pendingTask = List.from(pendingTask)
          ..insert(0, task.copyWith(isDone: false));
      } else {
        var index = favoritedTask.indexOf(task);
        completedTask = List.from(completedTask)..remove(task);
        pendingTask = List.from(pendingTask)
          ..insert(0, task.copyWith(isDone: false));
        favoritedTask = List.from(favoritedTask)
          ..remove(task)
          ..insert(index, task.copyWith(isDone: false));
      }
    }

    emit(TasksState(
      pendingTask: pendingTask,
      completedTask: completedTask,
      favoritedTask: favoritedTask,
      removedTask: state.removedTask,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
      pendingTask: state.pendingTask,
      completedTask: state.completedTask,
      favoritedTask: state.favoritedTask,
      removedTask: List.from(state.removedTask)..remove(event.task),
    ));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTask: List.from(state.pendingTask)..remove(event.task),
        completedTask: List.from(state.completedTask)..remove(event.task),
        favoritedTask: List.from(state.favoritedTask)..remove(event.task),
        removedTask: List.from(state.removedTask)
          ..add(event.task.copyWith(isDeleted: true))));
  }

  void _onFavoriteTask(MarkFavoriteOrNot event, Emitter<TasksState> emit) {
    final state = this.state;
    //final task = event.task;

    List<Task> pendingTask = state.pendingTask;
    List<Task> completedTask = state.completedTask;
    List<Task> favoritedTask = state.favoritedTask;

    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var index = pendingTask.indexOf(event.task);
        pendingTask = List.from(pendingTask)
          ..remove(event.task)
          ..insert(index, event.task.copyWith(isFavorite: true));
        favoritedTask = List.from(favoritedTask)
          ..insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var index = pendingTask.indexOf(event.task);
        pendingTask = List.from(pendingTask)
          ..remove(event.task)
          ..insert(index, event.task.copyWith(isFavorite: false));
        favoritedTask = List.from(favoritedTask)..remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        var index = completedTask.indexOf(event.task);
        completedTask = List.from(completedTask)
          ..remove(event.task)
          ..insert(index, event.task.copyWith(isFavorite: true));
        favoritedTask = List.from(favoritedTask)
          ..insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var index = completedTask.indexOf(event.task);
        completedTask = List.from(completedTask)
          ..remove(event.task)
          ..insert(index, event.task.copyWith(isFavorite: false));
        favoritedTask = List.from(favoritedTask)..remove(event.task);
      }
    }

    emit(TasksState(
      pendingTask: pendingTask,
      completedTask: completedTask,
      favoritedTask: favoritedTask,
      removedTask: state.removedTask,
    ));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTask: List.from(state.pendingTask)
        ..insert(
            0,
            event.task.copyWith(
              isFavorite: false,
              isDone: false,
              isDeleted: false,
            )),
      completedTask: List.from(state.completedTask)..remove(event.task),
      favoritedTask: List.from(state.favoritedTask)..remove(event.task),
      removedTask: List.from(state.removedTask)..remove(event.task),
    ));
  }

  void _onDeleteAllTask(DeleteAllTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      removedTask: List.from(state.removedTask)..clear(),
      pendingTask: state.pendingTask,
      completedTask: state.completedTask,
      favoritedTask: state.favoritedTask,
    ));
  }
}
