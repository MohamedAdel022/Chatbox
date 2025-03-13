import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final bool isLoading;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
    this.borderRadius = 10,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        foregroundColor: foregroundColor ?? Colors.black,
        backgroundColor: backgroundColor ?? Colors.white,
        minimumSize: Size(width ?? double.infinity, height ?? 50.h),
        disabledBackgroundColor:
            backgroundColor?.withOpacity(0.7) ?? Colors.grey[300],
      ),
      child: isLoading
          ? SizedBox(
              height: 20.h,
              width: 20.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: foregroundColor ?? Colors.black,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon!,
                  SizedBox(width: 8.w),
                ],
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (suffixIcon != null) ...[
                  SizedBox(width: 8.w),
                  suffixIcon!,
                ],
              ],
            ),
    );
  }
}
