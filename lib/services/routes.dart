import 'package:flutter/material.dart';

import '../screens/deleted_tasks_screen.dart';
import '../screens/completed_tasks_screen.dart';
import '../screens/tasks_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case CompletedTasksScreen.id:
        return MaterialPageRoute(
          builder: (_) => const CompletedTasksScreen(),
        );
      case DeletedTasksScreen.id:
        return MaterialPageRoute(
          builder: (_) => const DeletedTasksScreen(),
        );
      case TasksScreen.id:
        return MaterialPageRoute(
          builder: (_) => const TasksScreen(),
        );
      default:
        return null;
    }
  }
}
