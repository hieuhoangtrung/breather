import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  final int id;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String job;
  @JsonKey(name: 'profile_image_url')
  final String profileImageUrl;
  // final int bodyWeight;

  UserProfile({this.id, this.fullName, this.job, this.profileImageUrl});

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
