import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/features/messages/data/models/message_model.dart';
import 'package:chat/features/messages/domin/entities/message_entity.dart';
import 'package:chat/features/messages/domin/repos/message_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'message_state.dart';
part 'message_cubit.freezed.dart';

class MessageCubit extends Cubit<MessageState> {
  final MessageRepo messageRepo;
  StreamSubscription<List<MessageEntity>>? _messagesSubscription;

  MessageCubit({required this.messageRepo}) : super(MessageState.initial());

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }

  // Stream of messages for a specific chat
  void getMessages(String chatId) {
    // Cancel any existing subscription first
    _messagesSubscription?.cancel();

    emit(const MessageState.loading());
    try {
      _messagesSubscription = messageRepo.getMessages(chatId).listen(
        (messages) {
          emit(MessageState.success(messages));
        },
        onError: (error) {
          emit(MessageState.error(error.toString()));
        },
      );
    } catch (e) {
      emit(MessageState.error(e.toString()));
    }
  }

  // Send a new message
  Future<void> sendMessage({
    required String content,
    required String chatId,
    required String currentUserId,
    required String receiverId,
    String type = 'text',
    required String senderName,
    required String fcmToken,
  }) async {
    try {
      // Get the current messages if we have them
      final currentState = state;
      List<MessageEntity> currentMessages = [];

      if (currentState is _Success) {
        currentMessages = currentState.messages;
      }

      // Create the new message locally
      final message = MessageModel(
        id: const Uuid().v4(),
        fromId: currentUserId,
        toId: receiverId,
        message: content,
        timestamp: Timestamp.now(),
        // Automatically mark as read if sending to self
        isRead: currentUserId == receiverId,
        type: type,

      );

      // Add the temporary message to the current messages list (optimistic update)
      // MessageModel already extends MessageEntity, so we can use it directly
      final updatedMessages = [message, ...currentMessages];

      // Emit sending state with the optimistically updated messages
      emit(MessageState.sending(updatedMessages));

      // Now send the actual message to Firestore
      await messageRepo.sendMessage(message, chatId, senderName,fcmToken);

      // Note: We don't need to emit success state here as the getMessages stream
      // will automatically update with the new message
    } catch (e) {
      emit(MessageState.error(e.toString()));
    }
  }

  // Delete a message
  Future<void> deleteMessage(MessageEntity message, String chatId) async {
    try {
      await messageRepo.deleteMessage(message, chatId);
    } catch (e) {
      emit(MessageState.error(e.toString()));
    }
  }

  // Update a message (mark as read, edit content, etc)
  Future<void> updateMessage(MessageModel message, String chatId) async {
    try {
      await messageRepo.updateMessage(message, chatId);
    } catch (e) {
      emit(MessageState.error(e.toString()));
    }
  }

  // Read a message
  Future<void> readMessage(MessageEntity message, String chatId) async {
    try {
      await messageRepo.readMessage(message, chatId);
    } catch (e) {
      emit(MessageState.error(e.toString()));
    }
  }
}
