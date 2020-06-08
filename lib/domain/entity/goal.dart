import 'package:json_annotation/json_annotation.dart';

part 'goal.g.dart';

@JsonSerializable()
class Goal {
  final int id;
  final String name;
  final int color;
  final String icon;
  @JsonKey(name: 'due_date')
  final DateTime dueDate;

  Goal({this.id, this.name, this.color, this.icon, this.dueDate});

  Goal copy({String name, int id, int color, String icon, DateTime dueDate}) {
    return Goal(
      name: name ?? this.name,
      id: id ?? this.id,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      dueDate: dueDate ?? this.dueDate
    );
  }

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
