import 'package:equatable/equatable.dart';

class GitlabUser extends Equatable {
  final String name;
  final int id;
  final String username;

  const GitlabUser({
    this.name,
    this.id,
    this.username,
  });

  @override
  List<Object> get props => <Object>[
        this.name,
        this.id,
        this.username,
      ];
}
