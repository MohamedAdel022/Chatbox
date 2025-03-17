import 'package:chat/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAuthHeader extends StatelessWidget {
  const CustomAuthHeader(
      {super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            title,
            style: AppTextStyle.simiBoldBlack18,
          ),
        ),
        SizedBox(height: 20.h),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyle.simiBoldGray14,
            ),
          ),
        ),
      ],
    );
  }
}
