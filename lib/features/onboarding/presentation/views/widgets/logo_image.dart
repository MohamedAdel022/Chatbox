import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.imagesLogo1,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          "ChatBox",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontFamily: "CircularStd-Book",
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
