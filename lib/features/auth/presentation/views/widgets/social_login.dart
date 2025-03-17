import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: SvgPicture.asset(Assets.imagesFacebook),
          iconSize: 50.w,
          onPressed: () {
            // Handle Facebook login
          },
        ),
        SizedBox(width: 20.w),
        IconButton(
          icon: SvgPicture.asset(Assets.imagesGoogle),
          iconSize: 50.w,
          onPressed: () {
            // Handle Google login
          },
        ),
        SizedBox(width: 20.w),
        IconButton(
          icon: SvgPicture.asset(Assets.imagesApple),
          iconSize: 50.w,
          onPressed: () {
            // Handle Apple login
          },
        ),
      ],
    );
  }
}
