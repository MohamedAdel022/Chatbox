import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat/features/chats/domain/entities/chat_entity.dart';
import 'package:chat/features/auth/domin/entities/user_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({
    required super.id,
    required super.participants,
    super.otherUserInfo,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.lastSenderId,
    required super.unreadCount,
    required super.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json, {UserEntity? otherUser}) {
    return ChatModel(
      id: json['id'],
      participants: List<String>.from(json['participants']),
      otherUserInfo: otherUser, // Pass the other user info directly
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'] is Timestamp
          ? (json['lastMessageTime'] as Timestamp).toDate().toIso8601String()
          : json['lastMessageTime'],
      lastSenderId: json['lastSenderId'],
      unreadCount: json['unreadCount'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'lastSenderId': lastSenderId,
      'unreadCount': unreadCount,
      'createdAt': createdAt,
    };
  }

  static ChatModel empty() {
    return ChatModel(
      id: '',
      participants: [],
      otherUserInfo: null, // No user info for empty model
      lastMessage: '',
      lastMessageTime: DateTime.now().toIso8601String(),
      lastSenderId: '',
      unreadCount: 0,
      createdAt: DateTime.now().toIso8601String(),
    );
  }
}
