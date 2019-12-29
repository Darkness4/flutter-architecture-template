import 'package:flutter_architecture_template/domain/entities/firebase_auth/app_user.dart';

extension on AppUser {
  static AppUser fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      email: map['email'],
      photoUrl: map['photoURL'],
      displayName: map['displayName'],
      lastSeen: map['lastSeen'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'photoUrl': photoUrl,
      'displayName': displayName,
      'lastSeen': lastSeen,
    };
  }
}
