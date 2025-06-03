import 'package:chat/features/chats/presentation/views/chats_screen.dart';
import 'package:chat/features/chats/presentation/views/group_chats_screen.dart';
import 'package:chat/features/contacts/presentation/views/contacts_screen.dart';
import 'package:chat/features/navigation/presentation/view/widgets/nav_page_builder.dart';
import 'package:flutter/material.dart';

class NavPageView extends StatelessWidget {
  final int currentIndex;
  final PageController pageController;
  final ScrollController scrollController;
  final ValueChanged<int> onPageChanged;

  const NavPageView({
    super.key,
    required this.currentIndex,
    required this.pageController,
    required this.scrollController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: _pageBuilders.length,
      controller: pageController,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        return NavPageBuilder(
          builder: (context) => _pageBuilders[index](context),
        );
      },
    );
  }

  // List of page builder functions
  List<WidgetBuilder> get _pageBuilders => [
        // Chats Page (index 0)
        (context) => ChatsScreen(scrollController: scrollController),
        // Groups Page (index 1)
        (context) => GroupsChatsScreen(
              scrollController: scrollController,
            ),
        // Contacts Page (index 2)
        (context) => ContactsScreen(
              scrollController: scrollController,
            ),
        // Settings Page (index 3)
        (context) => Container(
              color: Colors.green,
              child: const Center(
                child: Text('Settings Page', style: TextStyle(fontSize: 24)),
              ),
            ),
      ];
}
