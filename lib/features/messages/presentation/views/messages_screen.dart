import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/widgets/background_container.dart';
import 'package:chat/features/messages/presentation/views/widgets/conversation_list_view.dart';
import 'package:chat/features/messages/presentation/views/widgets/home_header.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  final ScrollController? scrollController;

  const MessagesScreen({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            verticalSpace(20),
            HomeHeader(
              title: "Chats",
            ),
            verticalSpace(50),
            Expanded(
              child: BackgroundContainer(
                child: Column(
                  children: [
                    Expanded(
                      child: ConversatoinListView(
                        scrollController: scrollController,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
