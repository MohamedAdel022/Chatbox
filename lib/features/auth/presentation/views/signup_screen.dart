import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/features/auth/presentation/views/widgets/custom_back_button.dart';
import 'package:chat/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:chat/features/auth/presentation/views/widgets/signup_header.dart';
import 'package:chat/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Add a method to validate form fields and show error messages
  void _validateAndSubmit() {
    // Force show validation messages
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      print('Form is valid. Creating account...');
      print('Name: ${_nameController.text}');
      print('Password: ${_passwordController.text}');

      // Here you would typically call your authentication service
      // authService.signUp(_nameController.text, _passwordController.text);
    } else {
      print('Form validation failed. Please check the fields.');
    }
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.manual,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 20.h),
                          CustomBackButton(),
                          SizedBox(height: 50.h),
                          const CustomAuthHeader(
                            title: 'Sign up with Email',
                            subtitle:
                                'Get chatting with friends and family today by signing up for our chat app!',
                          ),
                          SizedBox(height: 50.h),
                          CustomTextField(
                            labelText: 'Your name',
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            labelText: 'Password',
                            isPassword: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            labelText: 'Confirm Password',
                            isPassword: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: CustomButton(
                    text: 'Create Account',
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    onPressed: _validateAndSubmit,
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
