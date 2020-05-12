import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Goal {
  final int id;
  final String name;
  final int color;
  final String icon;

  Goal({this.id, this.name, this.color, this.icon });

  Goal copy({String name, int id, int color, String icon }) {
    return Goal(
      name: name ?? this.name,
      id: id ?? this.id,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }
}
