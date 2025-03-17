import 'package:chat/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyle {
  static TextStyle simiBoldGrey68 = TextStyle(
    color: Colors.white,
    fontSize: 68.sp,
    fontFamily: 'Caros',
    fontWeight: FontWeight.w600,
  );
  static TextStyle regularGrey68 = TextStyle(
    color: Colors.white,
    fontSize: 68.sp,
    fontFamily: 'Caros',
    fontWeight: FontWeight.w400,
  );
  static TextStyle regularGrey16 = TextStyle(
    color: Color(0xFFB9C1BE),
    fontSize: 16.sp,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static TextStyle regularGrey14 = TextStyle(
    color: Color(0xFFB8C1BD),
    fontSize: 14.sp,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static TextStyle regularGreen14 = TextStyle(
    color: AppTheme.primaryColor,
    fontSize: 14,
    fontFamily: 'Circular Std',
    fontWeight: FontWeight.w500,
    height: 1,
    letterSpacing: 0.10,
  );
  static TextStyle mediumWhite14 = TextStyle(
    color: Colors.white,
    fontSize: 14.sp,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
  );
  static TextStyle simiBoldBlack18 = TextStyle(
    color: Color(0xFF000D07),
    fontSize: 18.sp,
    fontFamily: 'Caros',
    fontWeight: FontWeight.w600,
  );
  static TextStyle simiBoldGray14 = TextStyle(
    color: Color(0xFF797C7B),
    fontSize: 14.sp,
    fontFamily: AppTheme.fontFamily,
  );
  static TextStyle regularGray10 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}
