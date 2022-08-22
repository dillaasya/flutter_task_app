import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_app/services/guid_gen.dart';
import 'package:intl/intl.dart';

import '../bloc/task/tasks_bloc.dart';
import '../model/task.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Container(
      padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Add New Task'),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: titleController,
            autofocus: true,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), label: Text('Title')),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: descriptionController,
            maxLines: 4,
            minLines: 2,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), label: Text('Description')),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              IconButton(
                  onPressed: () {
                    var task = Task(
                        title: titleController.text,
                        id: GUIDGen.generate(),
                        date: DateFormat.yMEd().add_ms().format(DateTime.now()),
                        description: descriptionController.text,);

                    context.read<TasksBloc>().add(AddTask(task: task));
                    titleController.clear();
                    Navigator.pop(context);
                  },
                  icon: const Text('Add'))
            ],
          )
        ],
      ),
    );
  }
}
