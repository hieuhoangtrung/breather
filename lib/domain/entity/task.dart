import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Task {
  final int id;
  @JsonKey(name: 'goal_id')
  final int goalId;
  final String name;
  final String note;
  final int duration;
  @JsonKey(name: 'working_time')
  final int workingTime;
  final int priority;
  @JsonKey(name: 'loading_percent')
  final double loadingPercent;
  @JsonKey(name: 'due_date')
  final DateTime dueDate;
  @JsonKey(name: 'is_completed')
  final bool isCompleted;

  Task(
      {this.id,
      this.goalId,
      this.name,
      this.note,
      this.duration,
      this.workingTime,
      this.priority,
      this.loadingPercent,
      this.dueDate,
      this.isCompleted});

  Task copy(
      {int id,
      int goalId,
      String name,
      String note,
      int duration,
      int workingTime,
      double loadingPercent,
      DateTime dueDate}) {
    return Task(
        id: id ?? this.id,
        goalId: goalId ?? this.goalId,
        name: name ?? this.name,
        note: note ?? this.note,
        duration: duration ?? this.duration,
        workingTime: workingTime ?? this.workingTime,
        loadingPercent: loadingPercent ?? this.loadingPercent,
        dueDate: dueDate ?? this.dueDate);
  }
}
