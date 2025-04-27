import 'package:chat/features/auth/domin/entities/user_entity.dart';

class ChatEntity {
  final String id;
  final List<String> participants;
  final UserEntity? otherUserInfo; // Direct reference to the other user's info
  final String lastMessage;
  final String lastMessageTime;
  final String lastSenderId;
  final int unreadCount;
  final String createdAt;

  ChatEntity({
    required this.createdAt,
    required this.id,
    required this.participants,
    this.otherUserInfo, // Now we just need one user entity
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastSenderId,
    required this.unreadCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'lastSenderId': lastSenderId,
      'unreadCount': unreadCount,
    };
  }
}

