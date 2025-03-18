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
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        elevation: 10,
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
        animationDuration: const Duration(seconds: 10),
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        backgroundColor: Colors.white,
        destinations: navigationItems
            .map((item) => NavigationDestination(
                  icon: item.icon,
                  selectedIcon: item.selectedIcon,
                  label: item.label,
                ))
            .toList(),
      ),
    );
  }
}
