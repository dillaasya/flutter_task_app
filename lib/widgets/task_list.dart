import 'package:flutter/material.dart';
import 'package:flutter_task_app/widgets/task_tile.dart';
import '../model/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList.radio(
      children:
        taskList.map((task) =>
          ExpansionPanelRadio(
            value: task.id,
            headerBuilder: (context, isOpen)=> TaskTile(task: task),
            body: Padding(
              padding: const EdgeInsets.only(left:16, bottom: 16, right: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SelectableText(task.description,),
                  ],
                ),
              ),
            ),
          )
        ).toList()
      ,
    );
  }
}