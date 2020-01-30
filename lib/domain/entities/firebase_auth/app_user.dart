import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;
  final DateTime lastSeen;
  final bool isAdmin;

  const AppUser({
    this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
    this.lastSeen,
    this.isAdmin,
  });

  factory AppUser.setAdmin(AppUser user, bool value) {
    return AppUser(
      displayName: user.displayName,
      email: user.email,
      lastSeen: user.lastSeen,
      photoUrl: user.photoUrl,
      uid: user.uid,
      isAdmin: value,
    );
  }

  @override
  List<Object> get props => <Object>[
        this.uid,
        this.email,
        this.photoUrl,
        this.displayName,
        this.lastSeen,
        this.isAdmin,
      ];
}
