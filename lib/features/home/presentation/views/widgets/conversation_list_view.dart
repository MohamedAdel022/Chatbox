import 'package:chat/features/home/presentation/views/widgets/conversation_item.dart';
import 'package:flutter/material.dart';

class ConversatoinListView extends StatelessWidget {
  const ConversatoinListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ConversationItem();
      },
    );
  }
}