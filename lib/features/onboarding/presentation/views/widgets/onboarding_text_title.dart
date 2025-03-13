import 'package:chat/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class OnboradingTextTitle extends StatelessWidget {
  const OnboradingTextTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Connect\n',
            style: AppTextStyle.regular68,
          ),
          TextSpan(
            text: 'friends\n',
            style: AppTextStyle.regular68,
          ),
          TextSpan(
            text: 'easily &\n',
            style: AppTextStyle.simiBold68,
          ),
          TextSpan(
            text: 'quickly',
            style: AppTextStyle.simiBold68,
          ),
        ],
      ),
    );
  }
}