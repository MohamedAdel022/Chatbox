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
    required super.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json,
      {UserEntity? otherUser}) {
    return ChatModel(
      id: json['id'],
      participants: List<String>.from(json['participants']),
      otherUserInfo: otherUser, // Pass the other user info directly
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'] is Timestamp
          ? json['lastMessageTime'] as Timestamp
          : Timestamp.fromDate(DateTime.parse(json['lastMessageTime'])),
      lastSenderId: json['lastSenderId'],
      createdAt: json['createdAt'] is Timestamp
          ? json['createdAt'] as Timestamp
          : Timestamp.fromDate(DateTime.parse(json['createdAt'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'lastSenderId': lastSenderId,
      'createdAt': createdAt,
    };
  }

  static ChatModel empty() {
    return ChatModel(
      id: '',
      participants: [],
      otherUserInfo: null, // No user info for empty model
      lastMessage: '',
      lastMessageTime: Timestamp.now(),
      lastSenderId: '',
      createdAt: Timestamp.now(),
    );
  }
}
