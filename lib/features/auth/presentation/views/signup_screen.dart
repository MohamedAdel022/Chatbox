import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/features/auth/presentation/views/widgets/custom_back_button.dart';
import 'package:chat/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:chat/features/auth/presentation/views/widgets/signup_header.dart';
import 'package:chat/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20.h),
                        CustomBackButton(),
                        SizedBox(height: 50.h),
                        const SignupHeader(),
                        SizedBox(height: 50.h),
                        const CustomTextField(
                          labelText: 'Your name',
                        ),
                        SizedBox(height: 20.h),
                        const CustomTextField(
                          labelText: 'Password',
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(height: 20.h),
                        const CustomTextField(
                          labelText: 'Confirm Password',
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: CustomButton(
                    text: 'Create Account',
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      // Handle account creation logic
                      print('Create account button pressed');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
