import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task/tasks_bloc.dart';
import '../widgets/task_list.dart';

class PendingTaskScreen extends StatelessWidget {
  const PendingTaskScreen({Key? key}) : super(key: key);

  //static const id = 'task_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        //List<Task> taskList = state.pendingTask;

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
              TaskList(taskList: state.pendingTask)
            ],
          ),
        );
      },
    );
  }
}
