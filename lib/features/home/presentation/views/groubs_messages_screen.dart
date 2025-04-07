import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/widgets/background_container.dart';
import 'package:chat/features/home/presentation/views/widgets/conversation_list_view.dart';
import 'package:chat/features/home/presentation/views/widgets/home_header.dart';
import 'package:flutter/material.dart';

class GroubsMessagesScreen extends StatelessWidget {
  const GroubsMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
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
                    Expanded(
                      child: ConversatoinListView(),
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
