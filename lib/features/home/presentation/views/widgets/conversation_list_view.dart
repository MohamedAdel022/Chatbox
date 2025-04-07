import 'package:chat/features/home/presentation/views/widgets/conversation_item.dart';
import 'package:flutter/material.dart';

class ConversatoinListView extends StatelessWidget {
  final ScrollController? scrollController;

  const ConversatoinListView({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: 10,
      itemBuilder: (context, index) {
        return ConversationItem();
      },
    );
  }
}
