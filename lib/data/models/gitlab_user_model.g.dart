// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gitlab_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitlabUserModel _$GitlabUserModelFromJson(Map<String, dynamic> json) {
  return GitlabUserModel(
    name: json['name'] as String,
    id: json['id'] as int,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$GitlabUserModelToJson(GitlabUserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'username': instance.username,
    };
