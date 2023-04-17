import 'package:flutter/material.dart';

import '../screens/active_tasks_screen.dart';
import '../screens/deleted_tasks_screen.dart';
import '../screens/completed_tasks_screen.dart';
import '../screens/favorite_tasks.dart';
import '../screens/tabs_screen.dart';
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
      case ActiveTasksScreen.id:
        return MaterialPageRoute(
          builder: (_) => const ActiveTasksScreen(),
        );
      case FavoriteTasksScreen.id:
        return MaterialPageRoute(
          builder: (_) => const FavoriteTasksScreen(),
        );
      case TabsScreen.id:
        return MaterialPageRoute(
          builder: (_) => TabsScreen(),
        );
      default:
        return null;
    }
  }
}
