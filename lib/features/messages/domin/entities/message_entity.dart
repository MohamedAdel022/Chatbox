import 'package:cloud_firestore/cloud_firestore.dart';

class MessageEntity {
  String id;
  String fromId;
  String toId;
  String message;
  Timestamp timestamp;
  bool isRead;
  String type;

  MessageEntity({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.message,
    required this.timestamp,
    required this.isRead,
    required this.type,
  });
}
