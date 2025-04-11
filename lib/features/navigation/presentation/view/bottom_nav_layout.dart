import 'package:chat/core/helper/scroll_to_hide_controller.dart';
import 'package:chat/features/contacts/presentation/views/contacts_screen.dart';
import 'package:chat/features/messages/presentation/views/groubs_messages_screen.dart';
import 'package:chat/features/messages/presentation/views/messages_screen.dart';
import 'package:chat/features/navigation/domain/entities/bottom_navigation_entity.dart';
import 'package:chat/features/navigation/presentation/view/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class BottomNavLayout extends StatefulWidget {
  const BottomNavLayout({super.key});

  @override
  State<BottomNavLayout> createState() => _BottomNavLayoutState();
}

class _BottomNavLayoutState extends State<BottomNavLayout> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  late final ScrollToHideController _hideController;

  @override
  void initState() {
    super.initState();
    _hideController = ScrollToHideController();
    _hideController.init();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _hideController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ValueListenableBuilder<bool>(
          valueListenable: _hideController.isVisible,
          builder: (context, isVisible, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isVisible ? kBottomNavigationBarHeight + 30 : 0,
              child: Wrap(
                children: [
                  if (isVisible)
                    MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      removeTop: true,
                      child: CustomBottomNavBar(
                        currentIndex: _currentIndex,
                        onTap: _onTabTapped,
                        navigationItems: getBottomNavigationItems(),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        body: PageView(
          allowImplicitScrolling: false,
          padEnds: true,
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            // Home Page
            MessagesScreen(scrollController: _hideController.controller),
            // Chats Page
            GroubsMessagesScreen(
                key: ValueKey(_currentIndex == 1),
                scrollController: _hideController.controller),
            // Profile Page
            ContactsScreen(
              scrollController: _hideController.controller,
            ),
            // Settings Page
            Container(
              color: Colors.green,
              child: const Center(
                child: Text('Settings Page', style: TextStyle(fontSize: 24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
