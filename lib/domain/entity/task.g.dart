// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    id: json['id'] as int,
    goalId: json['goal_id'] as int,
    name: json['name'] as String,
    note: json['note'] as String,
    duration: json['duration'] as int,
    workingTime: json['working_time'] as int,
    priority: json['priority'] as int,
    loadingPercent: (json['loading_percent'] as num)?.toDouble(),
    dueDate: json['due_date'] == null
        ? null
        : DateTime.parse(json['due_date'] as String),
    isCompleted: json['is_completed'] as int,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'goal_id': instance.goalId,
      'name': instance.name,
      'note': instance.note,
      'duration': instance.duration,
      'working_time': instance.workingTime,
      'priority': instance.priority,
      'loading_percent': instance.loadingPercent,
      'due_date': instance.dueDate?.toIso8601String(),
      'is_completed': instance.isCompleted,
    };
