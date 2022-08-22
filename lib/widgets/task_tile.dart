import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_app/widgets/pop_up_menu.dart';

import '../bloc/task/tasks_bloc.dart';
import '../model/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: Row(
            children: [
              task.isFavorite == false
                  ? const Icon(Icons.star_outline)
                  : const Icon(Icons.star),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null),
                    ),
                    Text(task.date),
                    Text('status_fav : ${task.isFavorite}'),
                    Text('status_done : ${task.isDone}'),
                    Text('status_delete : ${task.isDeleted}'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: task.isDone,
              onChanged: task.isDeleted == false
                  ? (value) {
                      context.read<TasksBloc>().add(UpdateTask(task: task));
                    }
                  : null,
            ),
            PopUpMenu(
              cancelOrDeleteCallback: () => _removeOrDeleteTask(context, task),
              markFavoriteOrNot: () => context.read<TasksBloc>().add(
                    MarkFavoriteOrNot(task: task),
                  ),
              restoreDeletedTask: () => context.read<TasksBloc>().add(
                    RestoreTask(task: task),
                  ),
              task: task,
            )
          ],
        ),
      ]),
    );
  }
}
