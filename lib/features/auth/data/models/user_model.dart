import 'package:chat/features/auth/domin/entities/user_entity.dart';
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
          ? json['createdAt'] as Timestamp
          : Timestamp.fromDate(DateTime.parse(json['createdAt'])),
      lastActive: json['lastActive'] is Timestamp
          ? json['lastActive'] as Timestamp
          : Timestamp.fromDate(DateTime.parse(json['lastActive'])),
      isOnline: json['isOnline'],
      pushToken: json['pushToken'],
    );
  }


  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        imageUrl: user.imageUrl,
        bio: user.bio,
        createdAt: user.createdAt,
        lastActive: user.lastActive,
        isOnline: user.isOnline,
        pushToken: user.pushToken);
  }
    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'bio': bio,
      // Convert Timestamp to ISO8601 string for JSON serialization
      'createdAt': createdAt.toDate().toIso8601String(),
      'lastActive': lastActive.toDate().toIso8601String(),
      'isOnline': isOnline,
      'pushToken': pushToken,
    };
  }
}
