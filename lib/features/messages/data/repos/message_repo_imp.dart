import 'dart:convert';
import 'dart:developer';

import 'package:chat/core/service/fcm_service.dart';
import 'package:chat/core/utils/endpoints.dart';
import 'package:chat/core/utils/functions/get_user.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:chat/features/messages/data/models/message_model.dart';
import 'package:chat/features/messages/domin/entities/message_entity.dart';
import 'package:chat/features/messages/domin/repos/message_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageRepoImp implements MessageRepo {
  final FirebaseFirestore firestore;
  final FcmService fcmService;
  MessageRepoImp({required this.firestore, required this.fcmService});

  @override
  Future<void> deleteMessage(MessageEntity message, String chatId) {
    return firestore
        .collection(Endpoints.chats)
        .doc(chatId)
        .collection(Endpoints.messages)
        .doc(message.id)
        .delete();
  }

  @override
  Stream<List<MessageEntity>> getMessages(String chatId) {
    return firestore
        .collection(Endpoints.chats)
        .doc(chatId)
        .collection(Endpoints.messages)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList());
  }

  @override
  Future<void> sendMessage(MessageEntity message, String chatId,
      String senderName, String fcmToken) async {
    // Use the message ID as the document ID to ensure consistency
    await firestore
        .collection(Endpoints.chats)
        .doc(chatId)
        .collection(Endpoints.messages)
        .doc(message.id)
        .set(MessageModel.fromEntity(message).toMap());
    var user = await getUser();
    if (fcmToken.isNotEmpty) {
      await fcmService.sendNotification(
        recipientFCMToken: fcmToken,
        title: senderName,
        body: message.message,
        data: {'chatId': chatId,'user': jsonEncode(UserModel.fromEntity(user).toMap())},
      );
      await updateLastMessage(chatId, message);
    }
  }

  @override
  Future<void> updateMessage(MessageModel message, String chatId) {
    return firestore
        .collection(Endpoints.chats)
        .doc(chatId)
        .collection(Endpoints.messages)
        .doc(message.id)
        .update(message.toMap());
  }

  @override
  Future<void> readMessage(MessageEntity message, String chatId) async {
    try {
      log('Reading message: ${message.id}');
      await firestore
          .collection(Endpoints.chats)
          .doc(chatId)
          .collection(Endpoints.messages)
          .doc(message.id)
          .update({'isRead': true});
    } catch (e) {
      // If document not found, log error but don't crash the app
      log('Error updating read status: $e');
      // Document might not exist or ID might be incorrect
    }
  }

  Future<void> updateLastMessage(String chatId, MessageEntity message) async {
    await firestore.collection(Endpoints.chats).doc(chatId).update({
      'lastMessage': message.message,
      'lastMessageTime': message.timestamp,
      'lastSenderId': message.fromId,
    });
  }
}
