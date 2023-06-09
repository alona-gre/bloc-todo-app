import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/tasks_list.dart';
import 'add_task_screen.dart';
import 'my_drawer_screen.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  static const id = 'tasks_screen';

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
        List<Task> taskList = state.allTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                    '${state.completedTasks.length} Completed | ${taskList.length} All'),
              ),
            ),
            TasksList(taskList: taskList)
          ],
        );
      },
    );
  }
}
