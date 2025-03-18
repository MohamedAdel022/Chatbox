import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:chat/core/widgets/custom_buble_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBubleIconButton(
            onPressed: () {},
            icon: Assets.imagesSearch,
            pading: 11,
          ),
          Text(
            'Messages',
            style: AppTextStyle.mediumWhite20,
          ),
          CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(Assets.imagesTest),
          ),
        ],
      ),
    );
  }
}
