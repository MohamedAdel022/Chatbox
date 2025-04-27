import 'package:chat/features/messages/presentation/views/widgets/group_messages_item.dart';
import 'package:flutter/material.dart';

class GroupMessagesListView extends StatelessWidget {
  const GroupMessagesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        // Alternate between sender and receiver messages for demo
        return GroupMessagesItem(
          message:
              'This is message number ${index + 1}dsaffffffffffffffffffffffffffffffffsafasfsafasdfsdafasdfdsafdsafsdf',
          isSender: index % 2 == 0,
          time:
              '${12 + index % 12}:${index * 5 % 60 < 10 ? "0" : ""}${index * 5 % 60} ${index % 2 == 0 ? "AM" : "PM"}',
        );
      },
    );
  }
}
