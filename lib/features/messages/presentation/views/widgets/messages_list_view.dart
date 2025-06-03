import 'package:chat/features/messages/domin/entities/message_entity.dart';
import 'package:chat/features/messages/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat/features/messages/presentation/views/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          loading: () => const Center(child: CircularProgressIndicator()),
          sending: (messages) => _buildMessagesList(context, messages),
          success: (messages) => _buildMessagesList(context, messages),
          error: (error) => Center(child: Text('Error: $error')),
          orElse: () => const Center(child: CircularProgressIndicator()),
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

        return MessageItem(
          messageEntity: message,
          currentUserId: currentUserId,
          chatId: chatId,
          isSender: currentUserId==message.fromId ,
        );
      },
    );
  }
}
