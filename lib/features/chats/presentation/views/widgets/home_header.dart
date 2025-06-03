
import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:chat/core/widgets/custom_buble_icon_button.dart';
import 'package:chat/features/chats/presentation/views/widgets/header_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.title});
  final String title;
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
            title,
            style: AppTextStyle.mediumWhite20,
          ),
         const HeaderImage(),
        ],
      ),
    );
  }
}


