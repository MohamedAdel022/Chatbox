import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavigationEntity {
  final Widget icon;
  final Widget selectedIcon;
  final String label;

  const BottomNavigationEntity({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

List<BottomNavigationEntity> getBottomNavigationItems() => [
   BottomNavigationEntity(
          icon: SvgPicture.asset(
            Assets.imagesMessages,
            colorFilter:
                const ColorFilter.mode(AppTheme.inactiveBottomNavItemColor, BlendMode.srcIn),
          ),
          selectedIcon: SvgPicture.asset(
            Assets.imagesMessages,
            colorFilter:
                ColorFilter.mode(AppTheme.primaryColor, BlendMode.srcIn),
          ),
          label: 'Messages',
        ),
        BottomNavigationEntity(
          icon: const Icon(Iconsax.messages, color: AppTheme.inactiveBottomNavItemColor),
          selectedIcon: Icon(Iconsax.messages, color: AppTheme.primaryColor),
          label: 'Groups',
        ),
        BottomNavigationEntity(
          icon: SvgPicture.asset(
            Assets.imagesContacts,
            colorFilter:
                const ColorFilter.mode( AppTheme.inactiveBottomNavItemColor, BlendMode.srcIn),
          ),
          selectedIcon: SvgPicture.asset(
            Assets.imagesContacts,
            colorFilter:
                ColorFilter.mode(AppTheme.primaryColor, BlendMode.srcIn),
          ),
          label: 'Contacts',
        ),
        BottomNavigationEntity(
          icon: SvgPicture.asset(
            Assets.imagesSettings,
            colorFilter:
                const ColorFilter.mode(AppTheme.inactiveBottomNavItemColor, BlendMode.srcIn),
          ),
          selectedIcon: SvgPicture.asset(
            Assets.imagesSettings,
            colorFilter:
                ColorFilter.mode(AppTheme.primaryColor, BlendMode.srcIn),
          ),
          label: 'Settings',
        ),
];
