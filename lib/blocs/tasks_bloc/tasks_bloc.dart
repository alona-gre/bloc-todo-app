import 'package:bloc_todo_app/models/task.dart';
import 'package:equatable/equatable.dart';

import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<CompleteTask>(_onCompleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<DeleteTask>(_onDeleteTask);
    on<FavoriteTask>(_onFavoriteTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        allTasks: List.from(state.allTasks)..add(event.task),
        activeTasks: List.from(state.activeTasks)..add(event.task),
        favoriteTasks: state.favoriteTasks,
        removedTasks: state.removedTasks,
        completedTasks: state.completedTasks,
      ),
    );
  }

  void _onCompleteTask(CompleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> allTasks = state.allTasks;
    List<Task> activeTasks = state.activeTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    List<Task> completedTasks = state.completedTasks;

    var taskIndex = allTasks.indexOf(event.task);

    if (event.task.isDone == false) {
      allTasks = List.from(allTasks)
        ..remove(event.task)
        ..insert(taskIndex, event.task.copyWith(isDone: true));
      activeTasks = List.from(activeTasks)..remove(event.task);
      if (event.task.isFavorite == false) {
        favoriteTasks = List.from(favoriteTasks)..remove(event.task);
      } else {
        favoriteTasks = List.from(favoriteTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isDone: true));
      }
      completedTasks = List.from(completedTasks)
        ..insert(0, event.task.copyWith(isDone: true));
    } else //if event.task.isDone == true
    {
      allTasks = List.from(allTasks)
        ..remove(event.task)
        ..insert(taskIndex, event.task.copyWith(isDone: false));
      activeTasks = List.from(activeTasks)
        ..remove(event.task)
        ..insert(taskIndex, event.task.copyWith(isDone: false));
      if (event.task.isFavorite == false) {
        favoriteTasks = List.from(favoriteTasks)..remove(event.task);
      } else {
        favoriteTasks = List.from(favoriteTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isDone: false));
      }
      completedTasks = List.from(completedTasks)..remove(event.task);
    }

    emit(TasksState(
      allTasks: allTasks,
      activeTasks: activeTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
      completedTasks: completedTasks,
    ));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        allTasks: List.from(state.allTasks)..remove(event.task),
        activeTasks: List.from(state.activeTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(
            event.task.copyWith(isDeleted: true),
          ),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
      ),
    );
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        allTasks: List.from(state.allTasks)..remove(event.task),
        activeTasks: state.activeTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        completedTasks: state.completedTasks,
      ),
    );
  }

  void _onFavoriteTask(FavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> allTasks = state.allTasks;
    List<Task> activeTasks = state.activeTasks;
    List<Task> favoriteTasks = allTasks.where((tsk) {
      return tsk.isFavorite == true;
    }).toList();

    List<Task> completedTasks = state.completedTasks;

    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = allTasks.indexOf(event.task);

        allTasks = List.from(allTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        activeTasks = List.from(activeTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else //if event.task.isFavorite == true
      {
        var taskIndex = allTasks.indexOf(event.task);
        allTasks = List.from(allTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        activeTasks = List.from(activeTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    } else //if event.task.isDone == true
    {
      activeTasks = List.from(activeTasks)..remove(event.task);
      if (event.task.isFavorite == false) {
        var taskIndex = allTasks.indexOf(event.task);
        allTasks = List.from(allTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(
              taskIndex, event.task.copyWith(isFavorite: true, isDone: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else //if event.task.isFavorite == true
      {
        var taskIndex = allTasks.indexOf(event.task);
        allTasks = List.from(allTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }

    emit(
      TasksState(
        allTasks: allTasks,
        activeTasks: activeTasks,
        favoriteTasks: favoriteTasks,
        completedTasks: completedTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
