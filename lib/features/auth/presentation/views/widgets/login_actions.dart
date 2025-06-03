import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LoginActions extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onLogin;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onSignUp;

  const LoginActions({
    super.key,
    required this.isLoading,
    this.onLogin,
    this.onForgotPassword,
    this.onSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          text: 'Log In',
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          onPressed: isLoading ? null : onLogin,
          isLoading: isLoading,
        ),
        _buildForgotPasswordButton(),
      ],
    );
  }

  Widget _buildForgotPasswordButton() {
    return Center(
      child: TextButton(
        onPressed: isLoading ? null : onForgotPassword,
        child: Text(
          'Forgot password?',
          style: AppTextStyle.regularGreen14,
        ),
      ),
    );
  }
}
