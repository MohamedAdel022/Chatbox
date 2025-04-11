import 'package:chat/core/routing/routes.dart';
import 'package:chat/features/messages/presentation/views/widgets/conversation_item.dart';
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
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.pushNamed(context, Routes.chatScreen);
            },
            child: ConversationItem(),
          ),
        );
      },
    );
  }
}
