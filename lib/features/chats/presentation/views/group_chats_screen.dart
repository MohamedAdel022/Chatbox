import 'dart:developer';

import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/widgets/background_container.dart';
import 'package:chat/features/chats/presentation/views/widgets/home_header.dart';
import 'package:flutter/material.dart';

class GroupsChatsScreen extends StatefulWidget {
  final ScrollController? scrollController;

  const GroupsChatsScreen({super.key, this.scrollController});

  @override
  State<GroupsChatsScreen> createState() => _GroupsChatsScreenState();
}

class _GroupsChatsScreenState extends State<GroupsChatsScreen> {
  @override
  void initState() {
    log("groups screen is here. ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
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
    );
  }
}
