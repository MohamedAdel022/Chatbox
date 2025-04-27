import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/widgets/background_container.dart';
import 'package:chat/features/chats/presentation/views/widgets/home_header.dart';
import 'package:flutter/material.dart';

class GroupsChatsScreen extends StatelessWidget {
  final ScrollController? scrollController;

  const GroupsChatsScreen({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              verticalSpace(20),
              HomeHeader(
                title: "Groups",
              ),
              verticalSpace(50),
              Expanded(
                child: BackgroundContainer(
                  child: Column(
                    children: [
                      // Expanded(
                      //   child: ConversationListView(
                      //     scrollController: widget.scrollController,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
