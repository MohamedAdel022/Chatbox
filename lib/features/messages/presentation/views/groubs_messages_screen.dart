import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/core/widgets/background_container.dart';
import 'package:chat/features/messages/presentation/views/widgets/conversation_list_view.dart';
import 'package:chat/features/messages/presentation/views/widgets/home_header.dart';
import 'package:flutter/material.dart';

class GroubsMessagesScreen extends StatefulWidget {
  final ScrollController? scrollController;

  const GroubsMessagesScreen({super.key, this.scrollController});

  @override
  State<GroubsMessagesScreen> createState() => _GroubsMessagesScreenState();
}

class _GroubsMessagesScreenState extends State<GroubsMessagesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut.flipped,
      ),
    );
    // Start the animation when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: ScaleTransition(
          scale: _scaleAnimation,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: AppTheme.primaryColor,
            ),
          ),
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
                      child: ConversatoinListView(
                        scrollController: widget.scrollController,
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
