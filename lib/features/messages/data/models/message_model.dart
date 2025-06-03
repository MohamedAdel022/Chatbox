import 'package:chat/features/messages/domin/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.fromId,
    required super.toId,
    required super.message,
    required super.timestamp,
    required super.isRead,
    required super.type,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      fromId: map['fromId'],
      toId: map['toId'],
      message: map['message'],
      timestamp: map['timestamp'],
      isRead: map['isRead'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromId': fromId,
      'toId': toId,
      'message': message,
      'timestamp': timestamp,
      'isRead': isRead,
      'type': type,
    };
  }

  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      id: entity.id,
      fromId: entity.fromId,
      toId: entity.toId,
      message: entity.message,
      timestamp: entity.timestamp,
      isRead: entity.isRead,
      type: entity.type,
    );
  }
}
