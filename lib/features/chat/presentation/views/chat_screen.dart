import 'package:chat/features/chat/presentation/views/widgets/chat_app_bar.dart';
import 'package:chat/features/chat/presentation/views/widgets/chat_text_field.dart';
import 'package:chat/features/chat/presentation/views/widgets/messages_list_view.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ChatAppBar(),
      body: Column(
        children: [
          Expanded(
            child: MessagesListView(),
          ),
          ChatTextField(),
        ],
      ),
    );
  }
}
