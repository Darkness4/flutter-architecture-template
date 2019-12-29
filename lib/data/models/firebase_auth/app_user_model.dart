import 'package:equatable/equatable.dart';

class AppUserModel extends Equatable {
  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;
  final DateTime lastSeen;
  final bool isAdmin;

  const AppUserModel({
    this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
    this.lastSeen,
    this.isAdmin,
  });

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
      uid: map['uid'],
      email: map['email'],
      photoUrl: map['photoURL'],
      displayName: map['displayName'],
      lastSeen: map['lastSeen'],
      isAdmin: map['isAdmin'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'photoUrl': photoUrl,
      'displayName': displayName,
      'lastSeen': lastSeen,
      'isAdmmin': isAdmin,
    };
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
