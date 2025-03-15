import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:chat/core/widgets/custom_button.dart';
import 'package:chat/features/onboarding/presentation/views/widgets/logo_image.dart';
import 'package:chat/features/onboarding/presentation/views/widgets/onboarding_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
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
                  OnboradingTextTitle(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 19.w),
                    child: Text(
                      textAlign: TextAlign.left,
                      "Our chat app is the perfect way to stay connected with friends and family.",
                      style: AppTextStyle.regularGrey16,
                    ),
                  ),
                  Spacer(
                    flex: 5,
                  ),
                  CustomButton(
                    text: 'Get Started',
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.signupScreen);
                    },
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    width: double.infinity,
                    height: 50.h,
                    borderRadius: 10,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Center(
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: 'Existing account?',
                        style: AppTextStyle.regularGrey14,
                      ),
                      TextSpan(
                        text: ' Log in',
                        style: AppTextStyle.mediumWhite14,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, Routes.loginScreen);
                          },
                      ),
                    ])),
                  ),
                  Spacer(
                    flex: 2,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
