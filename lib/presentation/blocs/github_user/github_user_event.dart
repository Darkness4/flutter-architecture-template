import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class GetUserEvent extends GithubUserEvent {
  final String username;

  GetUserEvent(this.username);

  @override
  List<Object> get props => [username];
}

@immutable
abstract class GithubUserEvent extends Equatable {}
