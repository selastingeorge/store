import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String email;
  final String fullName;
  final String roleProfileName;
  final List<dynamic> roles;
  final String employeeId;
  final String authToken;

  User({
    required this.email,
    required this.fullName,
    required this.roleProfileName,
    required this.roles,
    required this.employeeId,
    required this.authToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
