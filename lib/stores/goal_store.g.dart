// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GoalStore on _GoalStore, Store {
  Computed<StoreState> _$stateComputed;

  @override
  StoreState get state => (_$stateComputed ??=
          Computed<StoreState>(() => super.state, name: '_GoalStore.state'))
      .value;

  final _$_futureGoalAtom = Atom(name: '_GoalStore._futureGoal');

  @override
  ObservableFuture<List<Goal>> get _futureGoal {
    _$_futureGoalAtom.reportRead();
    return super._futureGoal;
  }

  @override
  set _futureGoal(ObservableFuture<List<Goal>> value) {
    _$_futureGoalAtom.reportWrite(value, super._futureGoal, () {
      super._futureGoal = value;
    });
  }

  final _$goalsAtom = Atom(name: '_GoalStore.goals');

  @override
  List<Goal> get goals {
    _$goalsAtom.reportRead();
    return super.goals;
  }

  @override
  set goals(List<Goal> value) {
    _$goalsAtom.reportWrite(value, super.goals, () {
      super.goals = value;
    });
  }

  final _$loadGoalsAsyncAction = AsyncAction('_GoalStore.loadGoals');

  @override
  Future<dynamic> loadGoals() {
    return _$loadGoalsAsyncAction.run(() => super.loadGoals());
  }

  final _$addGoalAsyncAction = AsyncAction('_GoalStore.addGoal');

  @override
  Future<dynamic> addGoal(Goal goal) {
    return _$addGoalAsyncAction.run(() => super.addGoal(goal));
  }

  final _$deleteGoalAsyncAction = AsyncAction('_GoalStore.deleteGoal');

  @override
  Future<dynamic> deleteGoal(Goal goal) {
    return _$deleteGoalAsyncAction.run(() => super.deleteGoal(goal));
  }

  final _$updateGoalAsyncAction = AsyncAction('_GoalStore.updateGoal');

  @override
  Future<dynamic> updateGoal(Goal goal) {
    return _$updateGoalAsyncAction.run(() => super.updateGoal(goal));
  }

  final _$createTaskAsyncAction = AsyncAction('_GoalStore.createTask');

  @override
  Future<dynamic> createTask(Task task) {
    return _$createTaskAsyncAction.run(() => super.createTask(task));
  }

  final _$updateTaskAsyncAction = AsyncAction('_GoalStore.updateTask');

  @override
  Future<dynamic> updateTask(Task task) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(task));
  }

  final _$getTasksByGoalIdAsyncAction =
      AsyncAction('_GoalStore.getTasksByGoalId');

  @override
  Future<List<Task>> getTasksByGoalId(int goalId) {
    return _$getTasksByGoalIdAsyncAction
        .run(() => super.getTasksByGoalId(goalId));
  }

  @override
  String toString() {
    return '''
goals: ${goals},
state: ${state}
    ''';
  }
}
