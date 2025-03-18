import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      unselectedLabelStyle: TextStyle(
        color: Color(0xFF797C7B),
        fontSize: 16.sp,
        fontFamily: 'Caros',
        fontWeight: FontWeight.w400,
        height: 1,
      ),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: SvgPicture.asset(Assets.imagesMessages),
          ),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Icon(Icons.home),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ],
    );
  }
}