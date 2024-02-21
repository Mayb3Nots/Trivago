import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String name;
  final String uid;
  final UserRole role;

//<editor-fold desc="Data Methods">
  const UserModel({
    required this.name,
    required this.uid,
    required this.role,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          uid == other.uid &&
          role == other.role);

  @override
  int get hashCode => name.hashCode ^ uid.hashCode ^ role.hashCode;

  @override
  String toString() {
    return 'UserModel{ name: $name, uid: $uid, role: $role,}';
  }

  UserModel copyWith({
    String? name,
    String? uid,
    UserRole? role,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'role': role.name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      role: UserRole.fromName(map['role'])!,
    );
  }
}

enum UserRole {
  owner,
  manager,
  staff;

  static UserRole? fromName(String name) {
    for (UserRole enumVariant in UserRole.values) {
      if (enumVariant.name == name) return enumVariant;
    }
    return null;
  }
}
