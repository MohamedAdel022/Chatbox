import 'package:chat/core/helper/scroll_to_hide_controller.dart';
import 'package:chat/features/navigation/domain/entities/bottom_navigation_entity.dart';
import 'package:chat/features/navigation/presentation/view/widgets/custom_bottom_nav_bar.dart';
import 'package:chat/features/navigation/presentation/view/widgets/nav_page_view.dart';
import 'package:flutter/material.dart';

class BottomNavLayout extends StatefulWidget {
  const BottomNavLayout({super.key});

  @override
  State<BottomNavLayout> createState() => _BottomNavLayoutState();
}

class _BottomNavLayoutState extends State<BottomNavLayout> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(keepPage: true);
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
        body: NavPageView(
          currentIndex: _currentIndex,
          pageController: _pageController,
          scrollController: _hideController.controller,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
