import 'package:chat/features/messages/data/models/message_model.dart';
import 'package:chat/features/messages/domin/entities/message_entity.dart';

abstract class MessageRepo {
  Future<void> sendMessage(MessageModel message, String chatId, String senderName,String fcmToken);
  Stream<List<MessageEntity>> getMessages(String chatId);
  Future<void> updateMessage(MessageModel message, String chatId);
  Future<void> deleteMessage(MessageEntity message, String chatId);
  Future<void> readMessage(MessageEntity message, String chatId);
}