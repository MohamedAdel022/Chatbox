import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatEntity {
  final String id;
  final List<String> participants;
  final UserEntity? otherUserInfo; // Direct reference to the other user's info
  final String lastMessage;
  final Timestamp lastMessageTime;
  final String lastSenderId;
  final Timestamp createdAt;

  ChatEntity({
    required this.createdAt,
    required this.id,
    required this.participants,
    this.otherUserInfo, // Now we just need one user entity
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastSenderId,
  });


}

