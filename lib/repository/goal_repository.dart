import 'package:breather/domain/db_access/db_provider.dart';
import 'package:breather/domain/entity/goal.dart';
import 'package:breather/domain/entity/task.dart';

abstract class _GoalRepository {
  Future<List<Goal>> loadGoals();
  Future<List<Task>> getTasksByGoalId(int goalId);
  Future<List<Task>> getAllTask();
  Future<int> addGoal(Goal goal);
  Future<int> updateGoal(Goal goal);
  Future<void> deleteGoal(Goal goal);
  Future<int> createTask(Task task);
  Future<int> updateTask(Task task);
  Future<int> deleteTask(Task task);
}

class GoalRepository implements _GoalRepository {
  final _database = DBProvider.db;

  @override
  Future<List<Goal>> loadGoals() async {
    var isNew = !await _database.dbExists();
    if (isNew) {
      // handle newly created db here
      // insert default goals here
    }

    return _database.getAllGoal();
  }

  @override
  Future<int> addGoal(Goal goal) {
    return _database.insertGoal(goal);
  }

  @override
  Future<void> deleteGoal(Goal goal) {
    return _database.removeGoal(goal);
  }

  @override
  Future<int> updateGoal(Goal goal) {
    return _database.updateGoal(goal);
  }

  @override
  Future<int> createTask(Object task) {
    return _database.insertTask(task);
  }

  @override
  Future<int> updateTask(Task task) {
    return _database.updateTask(task);
  }

  @override
  Future<int> deleteTask(Task task) {
    return _database.removeTask(task);
  }

  @override
  Future<List<Task>> getTasksByGoalId(int goalId) {
    return _database.getTasksByGoalId(goalId);
  }

  @override
  Future<List<Task>> getAllTask() {
    return _database.getAllTask();
  }
}