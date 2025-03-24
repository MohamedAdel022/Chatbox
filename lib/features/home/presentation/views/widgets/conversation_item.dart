import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28.r,
        backgroundImage: AssetImage(Assets.imagesTest),
      ),
      title: const Text(
        'Profile',
        style: TextStyle(
          color: Color(0xFF000D07),
          fontSize: 20,
          fontFamily: 'Caros',
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      ),
      subtitle: Text(
        'View and edit your profile',
        style: TextStyle(
          color: const Color(0xFF797C7A),
          fontSize: 12,
          fontFamily: 'Circular Std',
          fontWeight: FontWeight.w400,
          height: 1,
        ),
      ),
      trailing: Column(
        children: [
          Text(
            '2 min ago',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: const Color(0xFF797C7B),
              fontSize: 12,
              fontFamily: 'Circular Std',
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
          verticalSpace(5),
          Container(
            width: 22.w,
            height: 22.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF04A4C),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
