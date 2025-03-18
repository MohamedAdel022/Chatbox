import 'package:chat/core/helper/spacing.dart';
import 'package:chat/features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:chat/features/home/presentation/views/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.black, 
        bottomNavigationBar: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: CustomBottomNavBar(),
        ),
        body: Column(
          children: [
            verticalSpace(20),
            HomeHeader(),
            Expanded(
              child: ListView(
                children: [
                  // Add your widgets here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


