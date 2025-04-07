import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/widgets/custom_back_button.dart';
import 'package:chat/features/auth/presentation/views/widgets/signup_header.dart';
import 'package:chat/features/auth/presentation/views/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat/features/auth/presentation/views/widgets/login_form.dart';
import 'package:chat/features/auth/presentation/views/widgets/login_actions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _validateAndSubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      setState(() => _isLoading = true);

      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));

        if (mounted) {
          print('Form is valid. Logging in...');
          print('Email: ${_emailController.text}');
          print('Password: ${_passwordController.text}');
          // TODO: Add actual login logic and navigation
          Navigator.pushNamed(context, Routes.bottomNavLayout);
        }
      } catch (e) {
        print('Error logging in: $e');
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    } else {
      print('Form validation failed. Please check the fields.');
    }
  }

  void _onForgotPasswordTap() {
    // TODO: Navigate to forgot password screen
    print('Navigate to forgot password');
  }

  void _onSignUpTap() {
    Navigator.pushNamed(context, Routes.signupScreen);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  const CustomBackButton(),
                  SizedBox(height: 30.h),
                  const CustomAuthHeader(
                    title: 'Log in to Chatbox',
                    subtitle:
                        'Welcome back! Sign in using your social account or email to continue us',
                  ),
                  SizedBox(height: 20.h),
                  SocialLogin(),
                  SizedBox(height: 20.h),
                  LoginForm(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  verticalSpace(75),
                  LoginActions(
                    isLoading: _isLoading,
                    onLogin: _validateAndSubmit,
                    onForgotPassword: _onForgotPasswordTap,
                    onSignUp: _onSignUpTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
