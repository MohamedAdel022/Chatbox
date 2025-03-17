import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  bool _hasError = false;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          validator: (value) {
            final error = widget.validator?.call(value);
            // Use Future to ensure setState happens after validation
            Future.microtask(() {
              if (mounted) {
                setState(() {
                  _hasError = error != null;
                  _errorText = error;
                });
              }
            });
            return error;
          },
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            labelStyle: TextStyle(
              color:
                  _hasError ? const Color(0xFFFF2D1B) : const Color(0xFF24786D),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
            hintStyle: AppTextStyle.regularGrey16,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            errorStyle: const TextStyle(
              height: 0,
              fontSize: 0,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: _hasError
                    ? const Color(0xFFFF2D1B)
                    : AppTheme.textColorTertiary,
                width: 1,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: _hasError
                    ? const Color(0xFFFF2D1B)
                    : AppTheme.textColorTertiary,
                width: 1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color:
                    _hasError ? const Color(0xFFFF2D1B) : AppTheme.primaryColor,
                width: 1.5,
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFFF2D1B),
                width: 1,
              ),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFFF2D1B),
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
        ),
        if (_hasError && _errorText != null)
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              _errorText!,
              style: const TextStyle(
                color: Color(0xFFFF2D1B),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            ),
          ),
      ],
    );
  }
}
