import 'package:flutter/material.dart';

import '../models/task.dart';

class PopupMenu extends StatelessWidget {
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback favoriteOrUnFavorite;
  final VoidCallback editTaskCallBack;
  final VoidCallback restoreTaskCallBack;
  final Task task;

  const PopupMenu({
    Key? key,
    required this.cancelOrDeleteCallback,
    required this.task,
    required this.favoriteOrUnFavorite,
    required this.editTaskCallBack,
    required this.restoreTaskCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? ((context) => [
                PopupMenuItem(
                  onTap: editTaskCallBack,
                  child: TextButton.icon(
                    onPressed: editTaskCallBack,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),
                PopupMenuItem(
                  onTap: favoriteOrUnFavorite,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: task.isFavorite == false
                        ? const Icon(Icons.bookmark_add_outlined)
                        : const Icon(Icons.bookmark_remove),
                    label: task.isFavorite == false
                        ? const Text('Add to Favorite')
                        : const Text('Remove from Favorite'),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                ),
              ])
          : ((context) => [
                PopupMenuItem(
                  onTap: restoreTaskCallBack,
                  child: TextButton.icon(
                    onPressed: restoreTaskCallBack,
                    icon: const Icon(Icons.restore),
                    label: const Text('Restore'),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Delete Forever'),
                  ),
                ),
              ]),
    );
  }
}
