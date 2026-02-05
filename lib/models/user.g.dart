// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  email: json['email'] as String,
  fullName: json['fullName'] as String,
  roleProfileName: json['roleProfileName'] as String,
  roles: json['roles'] as List<dynamic>,
  employeeId: json['employeeId'] as String,
  authToken: json['authToken'] as String,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'email': instance.email,
  'fullName': instance.fullName,
  'roleProfileName': instance.roleProfileName,
  'roles': instance.roles,
  'employeeId': instance.employeeId,
  'authToken': instance.authToken,
};
