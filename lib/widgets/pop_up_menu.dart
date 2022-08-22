import 'package:flutter/material.dart';

import '../model/task.dart';

class PopUpMenu extends StatelessWidget {
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback markFavoriteOrNot;
  final VoidCallback restoreDeletedTask;
  final Task task;

  const PopUpMenu({
    Key? key,
    required this.task,
    required this.markFavoriteOrNot,
    required this.cancelOrDeleteCallback,
    required this.restoreDeletedTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: task.isDeleted == false
            ? ((context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: task.isFavorite == false
                          ? const Icon(Icons.bookmark_add)
                          : const Icon(Icons.bookmark_remove),
                      label: task.isFavorite == false
                          ? const Text('Add to bookmark')
                          : const Text('Delete from bookmark'),
                    ),
                    onTap: markFavoriteOrNot,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                    ),
                    onTap: cancelOrDeleteCallback,
                  ),
                ])
            : (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.restore_rounded),
                      label: const Text('Restore'),
                    ),
                    onTap: restoreDeletedTask,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Delete Forever'),
                    ),
                    onTap: cancelOrDeleteCallback,
                  ),
                ]);
  }
}
