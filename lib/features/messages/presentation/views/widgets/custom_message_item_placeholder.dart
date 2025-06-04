import 'package:chat/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomMessageItemPlaceholder extends StatelessWidget {
  const CustomMessageItemPlaceholder({
    super.key,
    required this.isSender,
  });

  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        decoration: BoxDecoration(
          color: isSender
              ? AppTheme.secondaryColor.withValues(alpha: 0.5)
              : const Color(0xffF2F7FB),
          borderRadius: isSender
              ? const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
        ),
        height: 48,
      ),
    );
  }
}