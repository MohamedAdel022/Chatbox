import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:chat/features/messages/presentation/views/widgets/chat_app_bar.dart';
import 'package:chat/features/messages/presentation/views/widgets/chat_text_field.dart';
import 'package:chat/features/messages/presentation/views/widgets/messages_list_view.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ChatAppBar(user: user),
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
