import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultUserImage extends StatelessWidget {
  const DefaultUserImage({
    super.key,
    required this.radius,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: radius * 2.r,
        height: radius * 2.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(Assets.imagesUser),
            fit: BoxFit.cover,
          ),
        ),
      );
  }
}