import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;
  final DateTime lastSeen;

  const AppUser({
    this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
    this.lastSeen,
  });

  @override
  List<Object> get props => <Object>[
        this.uid,
        this.email,
        this.photoUrl,
        this.displayName,
        this.lastSeen,
      ];
}
