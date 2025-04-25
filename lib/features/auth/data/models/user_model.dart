import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.imageUrl,
    required super.bio,
    required super.createdAt,
    required super.lastActive,
    required super.isOnline,
    required super.pushToken,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      bio: json['bio'],
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.parse(json['createdAt']),
      lastActive: json['lastActive'] is Timestamp
          ? (json['lastActive'] as Timestamp).toDate()
          : DateTime.parse(json['lastActive']),
      isOnline: json['isOnline'],
      pushToken: json['pushToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'bio': bio,
      'createdAt': createdAt,
      'lastActive': lastActive,
      'isOnline': isOnline,
      'pushToken': pushToken,
    };
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      imageUrl: user.photoURL ?? '',
      bio: '',
      createdAt: DateTime.now(),
      lastActive: DateTime.now(),
      isOnline: true,
      pushToken: '',
    );
  }
}
