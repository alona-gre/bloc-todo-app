import 'package:flutter/material.dart';

import '../screens/deleted_tasks_screen.dart';
import '../screens/tasks_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
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
