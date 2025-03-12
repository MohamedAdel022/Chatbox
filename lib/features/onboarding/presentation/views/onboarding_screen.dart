import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:chat/features/onboarding/presentation/views/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                Assets.imagesEllipse,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  LogoImage(),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Connect\n',
                          style: AppTextStyle.regular68,
                        ),
                        TextSpan(
                          text: 'friends\n',
                          style: AppTextStyle.regular68,
                        ),
                        TextSpan(
                          text: 'easily &\n',
                          style: AppTextStyle.simiBold68,
                        ),
                        TextSpan(
                          text: 'quickly\n',
                          style: AppTextStyle.simiBold68,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
