import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final String bio;
  final Timestamp createdAt;
  final Timestamp lastActive;
  final bool isOnline;
  final String pushToken;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.bio,
    required this.createdAt,
    required this.lastActive,
    required this.isOnline,
    required this.pushToken,
  }); 
}
