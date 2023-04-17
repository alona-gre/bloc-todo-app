import 'package:bloc_todo_app/widgets/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Checkbox(
                  value: task.isDone,
                  onChanged: (value) {
                    context.read<TasksBloc>().add(CompleteTask(task: task));
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      Text(
                        DateFormat()
                            .add_yMMMEd()
                            .add_Hms()
                            .format(DateTime.parse(
                              task.createdDate,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            task.isFavorite == false
                ? IconButton(
                    icon: const Icon(Icons.star_outline),
                    onPressed: () => context.read<TasksBloc>().add(
                          FavoriteTask(task: task),
                        ),
                  )
                : IconButton(
                    icon: const Icon(Icons.star),
                    onPressed: () => context.read<TasksBloc>().add(
                          FavoriteTask(task: task),
                        ),
                  ),
            PopupMenu(
              task: task,
              cancelOrDeleteCallback: () => _removeOrDeleteTask(context, task),
              favoriteOrUnFavorite: () => context.read<TasksBloc>().add(
                    FavoriteTask(task: task),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
