import 'package:flutter/material.dart';
import 'package:chat/features/chat/presentation/views/widgets/message_item.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        // Alternate between sender and receiver messages for demo
        return MessageItem(
          message: 'This is message number ${index + 1}',
          isSender: index % 2 == 0,
          time:
              '${12 + index % 12}:${index * 5 % 60 < 10 ? "0" : ""}${index * 5 % 60} ${index % 2 == 0 ? "AM" : "PM"}',
        );
      },
    );
  }
}
