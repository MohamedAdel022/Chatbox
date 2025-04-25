import 'package:chat/core/helper/custom_snak_bar.dart';
import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/widgets/custom_back_button.dart';
import 'package:chat/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:chat/features/auth/presentation/views/widgets/signup_header.dart';
import 'package:chat/features/auth/presentation/views/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      context.read<SigninCubit>().signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );
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
    return BlocListener<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          Navigator.pushReplacementNamed(context, Routes.bottomNavLayout);
        } else if (state is SigninFailure) {
          showCustomSnackBar(context, state.message, color: Colors.red);
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.manual,
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
                    BlocBuilder<SigninCubit, SigninState>(
                      builder: (context, state) {
                        return LoginActions(
                          isLoading: state is SigninLoading,
                          onLogin: _validateAndSubmit,
                          onForgotPassword: _onForgotPasswordTap,
                          onSignUp: _onSignUpTap,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
