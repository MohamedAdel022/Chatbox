import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat/features/messages/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({
    required super.id,
    required super.participants,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.lastSenderId,
    required super.unreadCount,
    required super.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      participants: List<String>.from(json['participants']),
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
      lastMessage: '',
      lastMessageTime: DateTime.now().toIso8601String(),
      lastSenderId: '',
      unreadCount: 0,
      createdAt: DateTime.now().toIso8601String(),
    );
  }
}
