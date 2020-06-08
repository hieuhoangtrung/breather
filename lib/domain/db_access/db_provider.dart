import 'package:breather/domain/entity/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:breather/domain/entity/goal.dart';
import 'package:breather/domain/entity/task.dart';

class DBProvider {
  static Database _database;

  DBProvider._();
  static final DBProvider db = DBProvider._();

  // var todos = [
  //   Todo("Vegetables", parent: '1',),
  //   Todo("Birthday gift", parent: '1',),
  //   Todo("Chocolate cookies", parent: '1', isCompleted: 1),
  //   Todo("20 pushups", parent: '2',),
  //   Todo("Tricep", parent: '2',),
  //   Todo("15 burpees (3 sets)", parent: '2',),
  // ];

  // var tasks = [
  //   Task('Shopping', id: '1',  color: Colors.purple.value, codePoint: Icons.shopping_cart.codePoint),
  //   Task('Workout', id: '2', color: Colors.pink.value, codePoint: Icons.fitness_center.codePoint),
  // ];

  // var goals = [
  //   Goal()
  // ]

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  get _dbPath async {
    String documentsDirectory = await _localPath;
    return p.join(documentsDirectory, "Breather.db");
  }

  Future<bool> dbExists() async {
    return File(await _dbPath).exists();
  }

  initDB() async {
    String path = await _dbPath;
    return await openDatabase(path, version: 1, onOpen: (db) {

    }, onCreate: (Database db, int version) async {
      print("DBProvider:: onCreate()");
      await db.execute("CREATE TABLE UserProfile ("
          "id integer not null PRIMARY KEY autoincrement,"
          "full_name TEXT not null,"
          "job TEXT,"
          "profile_image_url TEXT"
          ")");
      await db.execute("CREATE TABLE Goal ("
          "id integer not null PRIMARY KEY autoincrement,"
          "name TEXT not null,"
          "color INTEGER,"
          "icon INTEGER,"
          "due_date text"
          ")");
      await db.execute("CREATE TABLE Task ("
          "id integer not null PRIMARY KEY autoincrement,"
          "goal_id integer default null,"
          "name TEXT not null,"
          "note TEXT,"
          "duration integer,"
          "working_time integer,"
          "priority integer,"
          "loading_percent real,"
          "due_date text,"
          "is_completed INTEGER NOT NULL DEFAULT 0,"
          "foreign key(goal_id) references Goal(id) on delete set null"
          ")");
    });
  }

  insertBulkTask(List<Task> tasks) async {
    final db = await database;
    tasks.forEach((it) async {
      var res = await db.insert("Task", it.toJson());
      print("Task ${it.id} = $res");
    });
  }

  insertBulkGoal(List<Goal> goals) async {
    final db = await database;
    goals.forEach((it) async {
      var res = await db.insert("Todo", it.toJson());
      print("Todo ${it.id} = $res");
    });
  }

  Future<List<Task>> getAllTask() async {
    final db = await database;
    var result = await db.query('Task');
    return result.map((it) => Task.fromJson(it)).toList();
  }

  Future<List<Task>> getTasksByGoalId(int goalId) async {
    final db = await database;
    var result = await db.query('Task', where: 'goal_id = ?', whereArgs: [goalId]);
    return result.map((it) => Task.fromJson(it)).toList();
  }

  Future<List<Goal>> getAllGoal() async {
    debugPrint('loading goal');
    final db = await database;
    var result = await db.query('Goal');
    return result.map((it) => Goal.fromJson(it)).toList();
  }

  Future<int> updateGoal(Goal goal) async {
    final db = await database;
    return db
        .update('Goal', goal.toJson(), where: 'id = ?', whereArgs: [goal.id]);
  }

  Future<void> removeGoal(Goal goal) async {
    final db = await database;
    return db.transaction<void>((txn) async {
      await txn.delete('Task', where: 'goal_id = ?', whereArgs: [goal.id]);
      await txn.delete('Goal', where: 'id = ?', whereArgs: [goal.id]);
    });
  }

  Future<int> insertGoal(Goal goal) async {
    final db = await database;
    return db.insert('Goal', goal.toJson());
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    return db.insert('Task', task.toJson());
  }

  Future<int> removeTask(Task task) async {
    final db = await database;
      return db.delete('Task', where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return db
        .update('Task', task.toJson(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> insertUserProfile(UserProfile userProfile) async {
    final db = await database;
    return db.insert('UserProfile', userProfile.toJson());
  }

  Future<int> updateUserProfile(UserProfile userProfile) async {
    final db = await database;
    return db.update('UserProfile', userProfile.toJson(), where: 'id = ?', whereArgs: [userProfile.id]);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  closeDB() {
    if (_database != null) {
      _database.close();
    }
  }
}
