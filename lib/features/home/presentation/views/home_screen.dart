import 'package:chat/core/helper/spacing.dart';

import 'package:chat/features/home/presentation/views/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,

        body: Column(
          children: [
            verticalSpace(20),
            HomeHeader(),
            verticalSpace(50),
            Expanded(
              child: Container(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
