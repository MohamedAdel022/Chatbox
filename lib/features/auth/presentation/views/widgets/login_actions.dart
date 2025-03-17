import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginActions extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;
  final VoidCallback onSignUp;

  const LoginActions({
    super.key,
    required this.isLoading,
    required this.onLogin,
    required this.onForgotPassword,
    required this.onSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: CustomButton(
            text: 'Log In',
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            onPressed: onLogin,
            isLoading: isLoading,
          ),
        ),
        _buildForgotPasswordButton(),
        _buildSignUpSection(),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildForgotPasswordButton() {
    return Center(
      child: TextButton(
        onPressed: onForgotPassword,
        child: Text(
          'Forgot password?',
          style: AppTextStyle.regularGreen14,
        ),
      ),
    );
  }

  Widget _buildSignUpSection() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: AppTextStyle.regularGray14,
          ),
          TextButton(
            onPressed: onSignUp,
            child: Text(
              'Sign up',
              style: AppTextStyle.regularGreen14,
            ),
          ),
        ],
      ),
    );
  }
}
