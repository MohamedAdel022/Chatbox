import 'package:chat/features/messages/presentation/views/widgets/group_messages_list_view.dart';
import 'package:flutter/material.dart';

class GroupMessagesScreen extends StatelessWidget {
  const GroupMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: ChatAppBar(),
      body: Column(
        children: [
          Expanded(
            child: GroupMessagesListView(),
          ),
         // ChatTextField(),
        ],
      ),
    );
  }
}
