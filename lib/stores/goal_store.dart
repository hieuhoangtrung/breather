import 'package:breather/domain/db_access/db_provider.dart';
import 'package:breather/domain/entity/goal.dart';
import 'package:breather/domain/entity/task.dart';
import 'package:breather/repository/goal_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'goal_store.g.dart';

class GoalStore extends _GoalStore with _$GoalStore {
  GoalStore(GoalRepository goalRepository): super(goalRepository);
}

enum StoreState { initial, loading, loaded }

abstract class _GoalStore with Store {
  final GoalRepository _goalRepository;

  _GoalStore(this._goalRepository);

  @observable
  ObservableFuture<List<Goal>> _futureGoal;

  @observable
  List<Goal> goals;

  @computed
  StoreState get state {
    if(_futureGoal == null || _futureGoal.status == FutureStatus.rejected)  {
      return StoreState.initial;
    }

    return _futureGoal.status == FutureStatus.pending ? StoreState.loading : StoreState.loaded;
  }

  @action
  Future loadGoals() async {
    _futureGoal = ObservableFuture(_goalRepository.loadGoals());
    goals = await _futureGoal;
  }

  @action
  Future addGoal(Goal goal) async {
    var rs = await _goalRepository.addGoal(goal);
    debugPrint('added goal id: $rs');
  }

  @action
  Future deleteGoal(Goal goal) async {
    await _goalRepository.deleteGoal(goal);
    print('deleted goal id: ${goal.id}');
  }

  @action
  Future updateGoal(Goal goal) async {
    var rs = await _goalRepository.updateGoal(goal);
    print('updated goal id: $rs');
  }

  @action
  Future createTask(Task task) async {
    var rs = await _goalRepository.createTask(task);
    print('created task id: $rs');
  }

  @action
  Future updateTask(Task task) async {
    var rs = await _goalRepository.updateTask(task);
    print('updated task id: $rs');
  }

  @action
  Future<List<Task>> getTasksByGoalId(int goalId) async {
    var rs = await _goalRepository.getTasksByGoalId(goalId);
    return rs;
  }
}