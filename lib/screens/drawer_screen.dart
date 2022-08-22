import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_app/screens/bottom_navbar_screen.dart';
import 'package:flutter_task_app/screens/recycle_bin_screen.dart';

import '../bloc/switch/switch_bloc.dart';
import '../bloc/task/tasks_bloc.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.grey,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: const Text(
                'Drawer',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Builder(builder: (context) {
              return BlocBuilder<TasksBloc, TasksState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, BottomNavbarScreen.id),
                    child: ListTile(
                      leading: const Icon(Icons.folder_special),
                      title: const Text('My Tasks'),
                      trailing: Text(
                  '${state.pendingTask.length} | ${state.completedTask.length}',
                ),
                    ),
                  );
                },
              );
            }),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, RecycleBinScreen.id),
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Bin'),
                    trailing: Text('${state.removedTask.length}'),
                  ),
                );
              },
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Switch(
                    value: state.switchValue,
                    onChanged: (newValue) {
                      newValue
                          ? context.read<SwitchBloc>().add(SwitchOn())
                          : context.read<SwitchBloc>().add(SwitchOff());
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
