import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomBubleIconButton extends StatelessWidget {
  const CustomBubleIconButton({
    super.key,
    required this.onPressed,
    required this.icon, required this.pading,
  });
  final void Function() onPressed;
  final String icon;
  final double pading;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: const Color(0xFF363F3B)),
        ),
        padding: EdgeInsets.all(pading.r),
        child: SvgPicture.asset(
          icon,
          fit: BoxFit.contain,
        ),
      ),
      onPressed: onPressed, // changed: use the provided callback
      // added: restrict splash/hightlight to circle
    );
  }
}
