import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/tasks_list.dart';
import 'add_task_screen.dart';

class FavoriteTasksScreen extends StatefulWidget {
  const FavoriteTasksScreen({Key? key}) : super(key: key);

  static const id = 'favorite_tasks_screen';

  @override
  State<FavoriteTasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<FavoriteTasksScreen> {
  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const AddTaskScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.favoriteTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text('${taskList.length} Favorite Tasks'),
              ),
            ),
            TasksList(taskList: taskList)
          ],
        );
      },
    );
  }
}
