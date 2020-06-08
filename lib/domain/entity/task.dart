import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final int id;
  @JsonKey(name: 'goal_id')
  final int goalId;
  @JsonKey(nullable: false)
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
  final int isCompleted;

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
      int isCompleted,
      DateTime dueDate}) {
    return Task(
        id: id ?? this.id,
        goalId: goalId ?? this.goalId,
        name: name ?? this.name,
        note: note ?? this.note,
        duration: duration ?? this.duration,
        workingTime: workingTime ?? this.workingTime,
        loadingPercent: loadingPercent ?? this.loadingPercent,
        isCompleted: isCompleted ?? this.isCompleted,
        dueDate: dueDate ?? this.dueDate);
  }

    factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
    Map<String, dynamic> toJson() => _$TaskToJson(this);
}
