import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/widgets/background_container.dart';
import 'package:chat/features/chats/presentation/views/widgets/conversation_list_view.dart';
import 'package:chat/features/chats/presentation/views/widgets/home_header.dart';
import 'package:flutter/material.dart';

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({
    super.key,
    required this.scrollController,
  });

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(
          title: "Chats",
        ),
        verticalSpace(50),
        Expanded(
          child: BackgroundContainer(
            child: Column(
              children: [
                Expanded(
                  child: ConversationListView(
                    scrollController: scrollController,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
