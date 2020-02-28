import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gitlab_user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GitlabUserModel extends Equatable {
  final String name;
  final int id;
  final String username;

  const GitlabUserModel({
    this.name,
    this.id,
    this.username,
  });

  factory GitlabUserModel.fromJson(Map<String, dynamic> json) =>
      _$GitlabUserModelFromJson(json);

  @override
  List<Object> get props => <Object>[
        this.name,
        this.id,
        this.username,
      ];

  Map<String, dynamic> toJson() => _$GitlabUserModelToJson(this);
}
