import 'package:chat/core/helper/custom_snak_bar.dart';
import 'package:chat/core/routing/routes.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:chat/features/auth/presentation/views/widgets/signup_form.dart';
import 'package:chat/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      context.read<SignupCubit>().signUpWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
            name: _nameController.text,
          );
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          showCustomSnackBar(context,
              'Account created successfully! Please check your email to verify your account.',
              color: Colors.green);
          // Navigate to login screen after successful signup
          Navigator.pushReplacementNamed(context, Routes.loginScreen);
        } else if (state is SignupFailure) {
          showCustomSnackBar(context, state.error, color: Colors.red);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.manual,
                      child: SignUpForm(
                          formKey: _formKey,
                          nameController: _nameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          confirmPasswordController: _confirmPasswordController,
                          autovalidateMode: _autovalidateMode),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return CustomButton(
                          text: state is SignupLoading
                              ? 'Creating Account...'
                              : 'Create Account',
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          isLoading: state is SignupLoading,
                          onPressed: state is SignupLoading
                              ? () {} // Empty function instead of null
                              : _validateAndSubmit,
                        );
                      },
                    ),
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
