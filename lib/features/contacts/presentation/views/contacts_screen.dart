import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/widgets/background_container.dart';
import 'package:chat/features/contacts/presentation/views/widgets/contacts_header.dart';
import 'package:chat/features/home/presentation/views/widgets/conversation_list_view.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key, this.scrollController});
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            verticalSpace(20),
            ContactsHeader(),
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
