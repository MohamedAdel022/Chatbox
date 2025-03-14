import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/features/auth/presentation/views/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              CustomBackButton(),
              SizedBox(height: 50.h),
              Center(
                child: Text(
                  'Log in to Chatbox',
                  style: AppTextStyle.simiBold18,
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    'Get chatting with friends and family today by signing up for our chat app!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF797C7B),
                      fontSize: 14,
                      fontFamily: 'Circular Std',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: 0.10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
