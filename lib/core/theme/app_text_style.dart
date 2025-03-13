import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyle {
  static TextStyle simiBold68 = TextStyle(
    color: Colors.white,
    fontSize: 68.sp,
    fontFamily: 'Caros',
    fontWeight: FontWeight.w600,
    height: 1.15,
  );
  static TextStyle regular68 = TextStyle(
    color: Colors.white,
    fontSize: 68.sp,
    fontFamily: 'Caros',
    fontWeight: FontWeight.w400,
    height: 1.15,
  );
  static TextStyle regular16 = TextStyle(
    color: Color(0xFFB9C1BE),
    fontSize: 16,
    fontFamily: 'Circular Std',
    fontWeight: FontWeight.w400,
    height: 1.62,
  );
  static TextStyle regular14 = TextStyle(
    color: Color(0xFFB8C1BD),
    fontSize: 14,
    fontFamily: 'Circular Std',
    fontWeight: FontWeight.w400,
    height: 1,
    letterSpacing: 0.10,
  );
  static TextStyle medium14 = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'Circular Std',
    fontWeight: FontWeight.w500,
    height: 1,
    letterSpacing: 0.10,
  );
}
