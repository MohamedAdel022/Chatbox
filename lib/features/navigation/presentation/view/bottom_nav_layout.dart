import 'package:chat/features/home/presentation/views/groubs_messages_screen.dart';
import 'package:chat/features/home/presentation/views/home_screen.dart';
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

  @override
  void dispose() {
    _pageController.dispose();
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
        bottomNavigationBar: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          removeTop: true,
          child: CustomBottomNavBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            navigationItems: getBottomNavigationItems(),
          ),
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
            HomeScreen(),
            // Chats Page
            GroubsMessagesScreen(),
            // Profile Page
            Container(
              color: Colors.white,
              child: const Center(
                child: Text('Profile Page', style: TextStyle(fontSize: 24)),
              ),
            ),
            // Settings Page
            Container(
              color: Colors.white,
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
