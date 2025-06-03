import 'dart:developer';

import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:chat/core/widgets/custom_back_button.dart';
import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({
    super.key,
    required this.user,
  });
  final UserEntity user;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: CustomBackButton(),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(Assets.imagesTest),
          ),
          horizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: AppTextStyle.mediumBlack16,
              ),
              Text(
                _getLastActiveText(user.lastActive),
                style: AppTextStyle.regularGrey12,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getLastActiveText(Timestamp lastActive) {
    log(lastActive.toString());
    final now = DateTime.now();
    final lastActiveDateTime = lastActive.toDate();
    final difference = now.difference(lastActiveDateTime);
    log(difference.toString());

    if (difference.inSeconds < 60) {
      return 'Active now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'min' : 'mins'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else {
      return '${lastActiveDateTime.day}/${lastActiveDateTime.month}/${lastActiveDateTime.year}';
    }
  }
}
