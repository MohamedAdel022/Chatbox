import 'package:chat/core/di/get_it.dart';
import 'package:chat/core/service/time_service.dart';
import 'package:chat/features/messages/domin/entities/message_entity.dart';
import 'package:chat/features/messages/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat/features/messages/presentation/views/widgets/sender_and_reciver_message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Factory class to create the appropriate message item based on sender status
class MessageItem extends StatefulWidget {
  final MessageEntity messageEntity;
  final String currentUserId;
  final String chatId;
  final bool isSender;
  final bool showReadMark;
  final bool showUnreadMark;

  const MessageItem({
    super.key,
    required this.messageEntity,
    required this.currentUserId,
    required this.chatId,
    required this.isSender,
    this.showReadMark = false,
    this.showUnreadMark = false,
  });

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  // Compute timeStr on demand
  String get timeStr {
    final timestamp = widget.messageEntity.timestamp.toDate();
    return getIt<TimeService>().formatMessageTime(timestamp);
  }

  @override
  void initState() {
    super.initState();
    _markMessageAsReadIfNeeded();
  }

  @override
  void didUpdateWidget(MessageItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if this is a new message or if read status has changed
    if (widget.messageEntity.id != oldWidget.messageEntity.id ||
        (!widget.messageEntity.isRead && oldWidget.messageEntity.isRead)) {
      _markMessageAsReadIfNeeded();
    }
  }

  void _markMessageAsReadIfNeeded() {
    // Mark message as read if it's not from the current user and not read yet
    if (!widget.isSender && !widget.messageEntity.isRead) {
      Future.microtask(() {
        // Check if widget is still mounted before using context
        if (mounted) {
          context
              .read<MessageCubit>()
              .readMessage(widget.messageEntity, widget.chatId);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if we're in a sending state to show sending indicator
    final currentState = context.watch<MessageCubit>().state;
    final bool isSending = currentState.maybeWhen(
          sending: (_) => true,
          orElse: () => false,
        ) &&
        widget.isSender &&
        !widget.messageEntity.isRead;

    return widget.isSender
        ? SenderMessageItem(
            message: widget.messageEntity.message,
            time: timeStr,
            showReadMark: widget.showReadMark,
            showUnreadMark: widget.showUnreadMark,
            isSending: isSending,
          )
        : ReceiverMessageItem(
            message: widget.messageEntity.message,
            time: timeStr,
          );
  }
}
