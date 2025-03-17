import 'package:chat/features/auth/presentation/views/widgets/custom_back_button.dart';
import 'package:chat/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:chat/features/auth/presentation/views/widgets/signup_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h),
          const CustomBackButton(),
          SizedBox(height: 50.h),
          const CustomAuthHeader(
            title: 'Log in to Chatbox',
            subtitle:
                'Welcome back! Sign in using your social account or email to continue us',
          ),
          SizedBox(height: 50.h),
          CustomTextField(
            labelText: 'Your email',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            labelText: 'Password',
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
            controller: passwordController,
            validator: _validatePassword,
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
