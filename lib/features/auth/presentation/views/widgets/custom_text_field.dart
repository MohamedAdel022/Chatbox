import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.hintText,
    this.isPassword = false,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: const TextStyle(
          color: Color(0xFF24786D),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        hintStyle: AppTextStyle.regularGrey16,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.textColorTertiary,
            width: 1,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.textColorTertiary,
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.primaryColor,
            width: 1.5,
          ),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: _obscureText
                      ? AppTheme.primaryColor
                      : AppTheme.textColorTertiary,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
