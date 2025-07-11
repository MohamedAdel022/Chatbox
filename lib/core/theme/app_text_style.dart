import 'package:chat/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyle {
  // Title & Heading Styles
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
  static TextStyle mediumWhite20 = TextStyle(
    color: Colors.white,
    fontSize: 20.sp,
    fontFamily: 'Caros',
    fontWeight: FontWeight.w500,
  );
  static TextStyle simiBoldBlack18 = TextStyle(
    color: Color(0xFF000D07),
    fontSize: 18.sp,
    fontFamily: 'Caros',
    fontWeight: FontWeight.w600,
  );
  
  // Conversation styles
  static TextStyle mediumBlack20 = TextStyle(
    color: Color(0xFF000D07),
    fontSize: 20.sp,
    fontFamily: 'Caros',
    fontWeight: FontWeight.w500,
    height: 1,
  );
  static TextStyle regularGray12 = TextStyle(
    color: Color(0xFF797C7A),
    fontSize: 12.sp,
    fontFamily: 'Circular Std',
    fontWeight: FontWeight.w400,
    height: 1,
  );
  static TextStyle mediumWhite12 = TextStyle(
    color: Colors.white,
    fontSize: 12.sp,
    fontFamily: 'Circular Std',
    fontWeight: FontWeight.w500,
  );
  
  // Regular Styles
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
  static TextStyle regularGrey12 = TextStyle(
    color: const Color(0xFF797C7B),
    fontSize: 12.sp,
    fontFamily: 'Circular Std',
    fontWeight: FontWeight.w400,
  );
  static TextStyle regularGray10 = TextStyle(
    fontSize: 10.sp,
    fontFamily: 'Circular Std',
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
  
  // Medium Styles
  static TextStyle mediumBlack16 = TextStyle(
    color: Colors.black,
    fontSize: 16.sp,
    fontFamily: 'Caros',
    fontWeight: FontWeight.w500,
  );
  static TextStyle mediumBlack14 = TextStyle(
    color: const Color(0xFF000D07),
    fontSize: 14,
    fontFamily: 'Caros',
    fontWeight: FontWeight.w500,
  );
  static TextStyle mediumWhite14 = TextStyle(
    color: Colors.white,
    fontSize: 14.sp,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
  );
  static TextStyle mediumGrey12 = TextStyle(
    color: const Color(0xFF797C7B),
    fontSize: 12.sp,
    fontFamily: 'Circular Std',
    fontWeight: FontWeight.w500,
  );
  
  // Special Styles
  static TextStyle regularGreen14 = TextStyle(
    color: AppTheme.primaryColor,
    fontSize: 14,
    fontFamily: 'Circular Std',
    fontWeight: FontWeight.w500,
    height: 1,
    letterSpacing: 0.10,
  );
  static TextStyle simiBoldGray14 = TextStyle(
    color: Color(0xFF797C7B),
    fontSize: 14.sp,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
  );
}
