import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/tasks_list.dart';
import 'add_task_screen.dart';
import 'my_drawer_screen.dart';

class ActiveTasksScreen extends StatefulWidget {
  const ActiveTasksScreen({Key? key}) : super(key: key);

  static const id = 'active_tasks_screen';

  @override
  State<ActiveTasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<ActiveTasksScreen> {
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
        List<Task> taskList = state.activeTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text('${taskList.length} Active Tasks'),
              ),
            ),
            TasksList(taskList: taskList)
          ],
        );
      },
    );
  }
}
