import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task/tasks_bloc.dart';
import '../widgets/task_list.dart';
import 'drawer_screen.dart';

class RecycleBinScreen extends StatelessWidget {
  const RecycleBinScreen({Key? key}) : super(key: key);

  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          child: TextButton.icon(
                            onPressed: null,
                            icon: const Icon(Icons.delete_outline),
                            label: const Text('Delete All Task'),
                          ),
                          onTap: () =>
                              context.read<TasksBloc>().add(DeleteAllTask())),
                    ]),
            ],
          ),
          drawer: const DrawerScreen(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child:
                        Chip(label: Text('${state.removedTask.length} Tasks'))),
                TaskList(taskList: state.removedTask)
              ],
            ),
          ),
        );
      },
    );
  }
}
