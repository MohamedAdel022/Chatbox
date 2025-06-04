import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/features/navigation/domain/entities/bottom_navigation_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationEntity> navigationItems;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.navigationItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      // Add padding to create space around the navigation bar
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          elevation: 0,
          height: 65.h,
          // Add padding inside the navigation bar for items
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          // Adjust internal padding between items
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 14.sp,
                fontFamily: 'Caros',
                fontWeight: FontWeight.w500,
              );
            }
            return TextStyle(
              color: AppTheme.inactiveBottomNavItemColor,
              fontSize: 14.sp,
              fontFamily: 'Caros',
              fontWeight: FontWeight.w400,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return IconThemeData(color: AppTheme.primaryColor);
            }
            return const IconThemeData(
                color: AppTheme.inactiveBottomNavItemColor);
          }),
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        child: NavigationBar(
          animationDuration: const Duration(milliseconds: 300),
          selectedIndex: currentIndex,
          onDestinationSelected: onTap,
          backgroundColor: Colors.white,
          // Add padding specifically to the NavigationBar
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: navigationItems
              .map((item) => NavigationDestination(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: item.icon,
                    ),
                    selectedIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: item.selectedIcon,
                    ),
                    label: item.label,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
