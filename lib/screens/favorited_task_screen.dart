import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_app/bloc/task/tasks_bloc.dart';

import '../widgets/task_list.dart';

class FavoritedTaskScreen extends StatelessWidget {
  const FavoritedTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        //List<Task> taskList = state.favoritedTask;

        return SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Chip(
                  label: Text(
                    '${state.pendingTask.length} Pending | ${state.completedTask.length} Completed | ${state.favoritedTask.length} Fav',
                  ),
                ),
              ),
              TaskList(taskList: state.favoritedTask)
            ],
          ),
        );
      },
    );
  }
}
