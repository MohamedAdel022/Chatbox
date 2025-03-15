import 'package:chat/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Sign up with Email',
            style: AppTextStyle.simiBoldBlack18,
          ),
        ),
        SizedBox(height: 20.h),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.w),
            child: Text(
              'Get chatting with friends and family today by signing up for our chat app!',
              textAlign: TextAlign.center,
              style: AppTextStyle.simiBoldGray14,
            ),
          ),
        ),
      ],
    );
  }
}
