import 'package:chat/features/messages/domin/entities/message_entity.dart';
import 'package:chat/features/messages/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat/features/messages/presentation/views/widgets/custom_message_item_placeholder.dart';
import 'package:chat/features/messages/presentation/views/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:chat/core/theme/app_theme.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView(
      {super.key, required this.chatId, required this.currentUserId});

  final String chatId;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    // Initialize message loading when widget is built
    context.read<MessageCubit>().getMessages(chatId);

    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => _buildLoadingSkeleton(context),
          sending: (messages) => _buildMessagesList(context, messages),
          success: (messages) => _buildMessagesList(context, messages),
          error: (error) => Center(child: Text('Error: $error')),
          orElse: () => _buildLoadingSkeleton(context),
        );
      },
    );
  }

  Widget _buildMessagesList(
      BuildContext context, List<MessageEntity> messages) {
    if (messages.isEmpty) {
      return const Center(child: Text('No messages yet'));
    }

    return ListView.builder(
      reverse: true, // Most recent messages at the bottom
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isSender = currentUserId == message.fromId;

        // Pre-compute read status flags
        bool allSenderRead = messages
            .where((m) => m.fromId == currentUserId)
            .every((m) => m.isRead);
        String? lastSenderMsgId;
        if (allSenderRead) {
          lastSenderMsgId = messages
              .firstWhere((m) => m.fromId == currentUserId)
              .id; // first because list reversed (latest)
        }

        final showReadMark =
            allSenderRead && message.id == lastSenderMsgId && isSender;
        final showUnreadMark = !allSenderRead && isSender && !message.isRead;

        return MessageItem(
          messageEntity: message,
          currentUserId: currentUserId,
          chatId: chatId,
          isSender: isSender,
          showReadMark: showReadMark,
          showUnreadMark: showUnreadMark,
        );
      },
    );
  }

  Widget _buildLoadingSkeleton(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        reverse: true,
        itemCount: 20,
        itemBuilder: (context, index) {
          final isSender = index % 2 == 0;
          return CustomMessageItemPlaceholder(isSender: isSender);
        },
      ),
    );
  }
}
